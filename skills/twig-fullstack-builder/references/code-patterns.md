# Code Patterns Reference

This document defines the canonical code patterns for the twig-fullstack-builder.
Every generated file must follow these patterns exactly.

---

## 1. DDD Entity pattern

```php
<?php
declare(strict_types=1);

namespace App\InvoicingBundle\Domain\Entity;

use App\InvoicingBundle\Domain\Event\InvoiceArchived;
use App\InvoicingBundle\Domain\Exception\InvoiceAlreadyArchivedException;
use App\InvoicingBundle\Domain\ValueObject\InvoiceStatus;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Uid\Uuid;

#[ORM\Entity]
#[ORM\Table(name: 'invoices')]
class Invoice
{
    #[ORM\Id]
    #[ORM\Column(type: 'uuid')]
    private Uuid $id;

    #[ORM\Column(type: 'string', length: 20, unique: true)]
    private string $invoiceNumber;

    #[ORM\Column(type: 'string', length: 20)]
    private string $status;

    #[ORM\Column(type: 'uuid')]
    private Uuid $workspaceId;

    #[ORM\Column(type: 'datetime_immutable')]
    private \DateTimeImmutable $createdAt;

    #[ORM\Column(type: 'datetime_immutable', nullable: true)]
    private ?\DateTimeImmutable $archivedAt = null;

    /** @var list<object> */
    private array $domainEvents = [];

    private function __construct(
        Uuid $id,
        string $invoiceNumber,
        Uuid $workspaceId,
    ) {
        $this->id = $id;
        $this->invoiceNumber = $invoiceNumber;
        $this->workspaceId = $workspaceId;
        $this->status = InvoiceStatus::DRAFT;
        $this->createdAt = new \DateTimeImmutable();
    }

    // --- Named constructor ---

    public static function create(
        string $invoiceNumber,
        Uuid $workspaceId,
    ): self {
        return new self(Uuid::v7(), $invoiceNumber, $workspaceId);
    }

    // --- Business methods (domain behavior) ---

    public function archive(): void
    {
        if ($this->status === InvoiceStatus::ARCHIVED) {
            throw new InvoiceAlreadyArchivedException($this->id);
        }

        $this->status = InvoiceStatus::ARCHIVED;
        $this->archivedAt = new \DateTimeImmutable();

        $this->recordEvent(new InvoiceArchived($this->id, $this->workspaceId));
    }

    // --- Domain events ---

    /** @return list<object> */
    public function pullDomainEvents(): array
    {
        $events = $this->domainEvents;
        $this->domainEvents = [];
        return $events;
    }

    private function recordEvent(object $event): void
    {
        $this->domainEvents[] = $event;
    }

    // --- Getters (no public setters for business state) ---

    public function getId(): Uuid { return $this->id; }
    public function getInvoiceNumber(): string { return $this->invoiceNumber; }
    public function getStatus(): string { return $this->status; }
    public function getWorkspaceId(): Uuid { return $this->workspaceId; }
    public function getCreatedAt(): \DateTimeImmutable { return $this->createdAt; }
    public function getArchivedAt(): ?\DateTimeImmutable { return $this->archivedAt; }

    public function isArchived(): bool
    {
        return $this->status === InvoiceStatus::ARCHIVED;
    }
}
```

---

## 2. Value Object pattern

```php
<?php
declare(strict_types=1);

namespace App\InvoicingBundle\Domain\ValueObject;

final class InvoiceStatus
{
    public const DRAFT = 'draft';
    public const VALIDATED = 'validated';
    public const SENT = 'sent';
    public const PAID = 'paid';
    public const ARCHIVED = 'archived';

    public const VALID_STATUSES = [
        self::DRAFT,
        self::VALIDATED,
        self::SENT,
        self::PAID,
        self::ARCHIVED,
    ];

    private function __construct(private readonly string $value)
    {
        if (!in_array($value, self::VALID_STATUSES, true)) {
            throw new \InvalidArgumentException(sprintf('Invalid status: %s', $value));
        }
    }

    public static function from(string $status): self
    {
        return new self($status);
    }

    public function getValue(): string { return $this->value; }
    public function __toString(): string { return $this->value; }
    public function equals(self $other): bool { return $this->value === $other->value; }
}
```

---

## 3. Domain Event pattern

```php
<?php
declare(strict_types=1);

namespace App\InvoicingBundle\Domain\Event;

use Symfony\Component\Uid\Uuid;

final readonly class InvoiceArchived
{
    public function __construct(
        public readonly Uuid $invoiceId,
        public readonly Uuid $workspaceId,
        public readonly \DateTimeImmutable $occurredAt = new \DateTimeImmutable(),
    ) {}
}
```

---

## 4. Repository interface pattern

```php
<?php
declare(strict_types=1);

namespace App\InvoicingBundle\Domain\Repository;

use App\InvoicingBundle\Domain\Entity\Invoice;
use Symfony\Component\Uid\Uuid;

interface InvoiceRepositoryInterface
{
    public function findById(Uuid $id): ?Invoice;
    public function findOrFail(Uuid $id): Invoice; // throws InvoiceNotFoundException
    public function findByWorkspaceId(Uuid $workspaceId): array;
    public function save(Invoice $invoice): void;
    public function remove(Invoice $invoice): void;
}
```

---

## 5. Domain Exception pattern

```php
<?php
declare(strict_types=1);

namespace App\InvoicingBundle\Domain\Exception;

use Symfony\Component\Uid\Uuid;

final class InvoiceAlreadyArchivedException extends \DomainException
{
    public function __construct(Uuid $invoiceId)
    {
        parent::__construct(sprintf('Invoice "%s" is already archived.', $invoiceId));
    }
}

final class InvoiceNotFoundException extends \DomainException
{
    public function __construct(Uuid $invoiceId)
    {
        parent::__construct(sprintf('Invoice "%s" not found.', $invoiceId));
    }
}
```

---

## 6. Command pattern (immutable DTO)

```php
<?php
declare(strict_types=1);

namespace App\InvoicingBundle\Application\Command;

use Symfony\Component\Uid\Uuid;

final readonly class ArchiveInvoiceCommand
{
    public function __construct(
        public readonly Uuid $invoiceId,
        public readonly Uuid $requestedByUserId,
    ) {}
}
```

---

## 7. CommandHandler pattern (Messenger)

```php
<?php
declare(strict_types=1);

namespace App\InvoicingBundle\Application\CommandHandler;

use App\InvoicingBundle\Application\Command\ArchiveInvoiceCommand;
use App\InvoicingBundle\Domain\Exception\InvoiceNotFoundException;
use App\InvoicingBundle\Domain\Repository\InvoiceRepositoryInterface;
use Symfony\Component\Messenger\Attribute\AsMessageHandler;
use Symfony\Component\Messenger\MessageBusInterface;

#[AsMessageHandler]
final class ArchiveInvoiceHandler
{
    public function __construct(
        private readonly InvoiceRepositoryInterface $invoiceRepository,
        private readonly MessageBusInterface $eventBus,
    ) {}

    public function __invoke(ArchiveInvoiceCommand $command): void
    {
        $invoice = $this->invoiceRepository->findById($command->invoiceId)
            ?? throw new InvoiceNotFoundException($command->invoiceId);

        $invoice->archive(); // domain business method

        $this->invoiceRepository->save($invoice);

        // Dispatch all domain events raised during the operation
        foreach ($invoice->pullDomainEvents() as $event) {
            $this->eventBus->dispatch($event);
        }
    }
}
```

---

## 8. Voter pattern

```php
<?php
declare(strict_types=1);

namespace App\InvoicingBundle\Presentation\Security\Voter;

use App\InvoicingBundle\Domain\Entity\Invoice;
use App\IdentityBundle\Domain\Entity\User;
use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\Security\Core\Authorization\Voter\Voter;

/**
 * @extends Voter<string, Invoice>
 */
final class InvoiceVoter extends Voter
{
    public const ARCHIVE = 'INVOICE_ARCHIVE';
    public const VIEW = 'INVOICE_VIEW';
    public const EDIT = 'INVOICE_EDIT';

    protected function supports(string $attribute, mixed $subject): bool
    {
        return in_array($attribute, [self::ARCHIVE, self::VIEW, self::EDIT], true)
            && $subject instanceof Invoice;
    }

    protected function voteOnAttribute(string $attribute, mixed $subject, TokenInterface $token): bool
    {
        $user = $token->getUser();
        if (!$user instanceof User) {
            return false;
        }

        /** @var Invoice $invoice */
        $invoice = $subject;

        return match ($attribute) {
            self::ARCHIVE => $this->canArchive($user, $invoice),
            self::VIEW => $this->canView($user, $invoice),
            self::EDIT => $this->canEdit($user, $invoice),
            default => false,
        };
    }

    private function canArchive(User $user, Invoice $invoice): bool
    {
        // Only workspace admins can archive
        // TODO: resolve workspace admin role check from identity module
        return $user->isWorkspaceAdmin($invoice->getWorkspaceId());
    }

    private function canView(User $user, Invoice $invoice): bool
    {
        return $user->isMemberOfWorkspace($invoice->getWorkspaceId());
    }

    private function canEdit(User $user, Invoice $invoice): bool
    {
        return $user->isMemberOfWorkspace($invoice->getWorkspaceId())
            && !$invoice->isArchived();
    }
}
```

---

## 9. Symfony Workflow integration in a Service

```php
<?php
declare(strict_types=1);

namespace App\InvoicingBundle\Application\CommandHandler;

use App\InvoicingBundle\Application\Command\ArchiveInvoiceCommand;
use App\InvoicingBundle\Domain\Repository\InvoiceRepositoryInterface;
use Symfony\Component\Messenger\Attribute\AsMessageHandler;
use Symfony\Component\Messenger\MessageBusInterface;
use Symfony\Component\Workflow\WorkflowInterface;

#[AsMessageHandler]
final class ArchiveInvoiceHandler
{
    public function __construct(
        private readonly InvoiceRepositoryInterface $invoiceRepository,
        private readonly WorkflowInterface $invoiceWorkflow,  // injected by name via services.yaml
        private readonly MessageBusInterface $eventBus,
    ) {}

    public function __invoke(ArchiveInvoiceCommand $command): void
    {
        $invoice = $this->invoiceRepository->findOrFail($command->invoiceId);

        if (!$this->invoiceWorkflow->can($invoice, 'archive')) {
            throw new \DomainException('Cannot archive invoice in current state: ' . $invoice->getStatus());
        }

        $this->invoiceWorkflow->apply($invoice, 'archive');

        $this->invoiceRepository->save($invoice);

        foreach ($invoice->pullDomainEvents() as $event) {
            $this->eventBus->dispatch($event);
        }
    }
}
```

Workflow service injection in services.yaml:
```yaml
App\InvoicingBundle\Application\CommandHandler\ArchiveInvoiceHandler:
    arguments:
        $invoiceWorkflow: '@state_machine.invoice'
```

---

## 10. Doctrine Repository Implementation pattern

```php
<?php
declare(strict_types=1);

namespace App\InvoicingBundle\Infrastructure\Persistence\Doctrine\Repository;

use App\InvoicingBundle\Domain\Entity\Invoice;
use App\InvoicingBundle\Domain\Exception\InvoiceNotFoundException;
use App\InvoicingBundle\Domain\Repository\InvoiceRepositoryInterface;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\Uid\Uuid;

final class DoctrineInvoiceRepository extends ServiceEntityRepository implements InvoiceRepositoryInterface
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Invoice::class);
    }

    public function findById(Uuid $id): ?Invoice
    {
        return $this->find($id);
    }

    public function findOrFail(Uuid $id): Invoice
    {
        return $this->findById($id) ?? throw new InvoiceNotFoundException($id);
    }

    public function findByWorkspaceId(Uuid $workspaceId): array
    {
        return $this->createQueryBuilder('i')
            ->andWhere('i.workspaceId = :workspaceId')
            ->setParameter('workspaceId', $workspaceId, 'uuid')
            ->orderBy('i.createdAt', 'DESC')
            ->getQuery()
            ->getResult();
    }

    public function save(Invoice $invoice): void
    {
        $this->getEntityManager()->persist($invoice);
        $this->getEntityManager()->flush();
    }

    public function remove(Invoice $invoice): void
    {
        $this->getEntityManager()->remove($invoice);
        $this->getEntityManager()->flush();
    }
}
```

---

## 11. Controller with Turbo support pattern

```php
<?php
declare(strict_types=1);

namespace App\InvoicingBundle\Presentation\Controller;

use App\InvoicingBundle\Application\Command\ArchiveInvoiceCommand;
use App\InvoicingBundle\Domain\Exception\InvoiceAlreadyArchivedException;
use App\InvoicingBundle\Domain\Exception\InvoiceNotFoundException;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Messenger\MessageBusInterface;
use Symfony\Component\Messenger\Stamp\HandledStamp;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Component\Uid\Uuid;
use Symfony\UX\Turbo\TurboBundle;

#[Route('/invoices', name: 'invoicing_')]
final class InvoiceController extends AbstractController
{
    public function __construct(
        private readonly MessageBusInterface $commandBus,
    ) {}

    #[Route('/{id}/archive', name: 'archive', methods: ['POST'])]
    #[IsGranted('INVOICE_ARCHIVE', subject: 'invoice')]   // uses InvoiceVoter
    public function archive(
        string $id,
        Request $request,
    ): Response {
        // CSRF protection
        if (!$this->isCsrfTokenValid('archive_invoice_' . $id, $request->getPayload()->getString('_token'))) {
            throw $this->createAccessDeniedException('Invalid CSRF token.');
        }

        try {
            $this->commandBus->dispatch(new ArchiveInvoiceCommand(
                invoiceId: Uuid::fromString($id),
                requestedByUserId: $this->getUser()->getId(),
            ));

            $this->addFlash('success', 'Invoice archived successfully.');

        } catch (InvoiceAlreadyArchivedException $e) {
            $this->addFlash('warning', 'This invoice is already archived.');
        } catch (InvoiceNotFoundException $e) {
            throw $this->createNotFoundException('Invoice not found.');
        }

        // Turbo Stream response for in-place update
        if (TurboBundle::STREAM_FORMAT === $request->getPreferredFormat()) {
            $request->setRequestFormat(TurboBundle::STREAM_FORMAT);
            return $this->render('@Invoicing/invoice/_archive_stream.html.twig', [
                'invoiceId' => $id,
            ]);
        }

        return $this->redirectToRoute('invoicing_list');
    }
}
```
