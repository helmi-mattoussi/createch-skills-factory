# Test Patterns Reference

## PHPUnit + Behat setup and code patterns

---

## 1. PHPUnit — CommandHandler unit test

```php
<?php
declare(strict_types=1);

namespace App\InvoicingBundle\Tests\Unit\Application\CommandHandler;

use App\InvoicingBundle\Application\Command\ArchiveInvoiceCommand;
use App\InvoicingBundle\Application\CommandHandler\ArchiveInvoiceHandler;
use App\InvoicingBundle\Domain\Entity\Invoice;
use App\InvoicingBundle\Domain\Exception\InvoiceAlreadyArchivedException;
use App\InvoicingBundle\Domain\Exception\InvoiceNotFoundException;
use App\InvoicingBundle\Domain\Repository\InvoiceRepositoryInterface;
use PHPUnit\Framework\MockObject\MockObject;
use PHPUnit\Framework\TestCase;
use Symfony\Component\Messenger\Envelope;
use Symfony\Component\Messenger\MessageBusInterface;
use Symfony\Component\Uid\Uuid;

final class ArchiveInvoiceHandlerTest extends TestCase
{
    private InvoiceRepositoryInterface&MockObject $invoiceRepository;
    private MessageBusInterface&MockObject $eventBus;
    private ArchiveInvoiceHandler $handler;

    protected function setUp(): void
    {
        $this->invoiceRepository = $this->createMock(InvoiceRepositoryInterface::class);
        $this->eventBus = $this->createMock(MessageBusInterface::class);
        $this->eventBus->method('dispatch')->willReturnCallback(
            fn(object $message) => new Envelope($message)
        );
        $this->handler = new ArchiveInvoiceHandler(
            $this->invoiceRepository,
            $this->eventBus,
        );
    }

    /** @test */
    public function it_archives_a_draft_invoice(): void
    {
        $invoiceId = Uuid::v7();
        $invoice = Invoice::create('INV-001', Uuid::v7());

        $this->invoiceRepository
            ->method('findById')
            ->with($invoiceId)
            ->willReturn($invoice);

        $this->invoiceRepository->expects($this->once())->method('save')->with($invoice);

        ($this->handler)(new ArchiveInvoiceCommand($invoiceId, Uuid::v7()));

        $this->assertTrue($invoice->isArchived());
    }

    /** @test */
    public function it_throws_when_invoice_not_found(): void
    {
        $this->expectException(InvoiceNotFoundException::class);

        $invoiceId = Uuid::v7();

        $this->invoiceRepository
            ->method('findById')
            ->with($invoiceId)
            ->willReturn(null);

        ($this->handler)(new ArchiveInvoiceCommand($invoiceId, Uuid::v7()));
    }

    /** @test */
    public function it_throws_when_invoice_already_archived(): void
    {
        $this->expectException(InvoiceAlreadyArchivedException::class);

        $invoiceId = Uuid::v7();
        $invoice = Invoice::create('INV-001', Uuid::v7());
        $invoice->archive(); // already archived

        $this->invoiceRepository
            ->method('findById')
            ->with($invoiceId)
            ->willReturn($invoice);

        ($this->handler)(new ArchiveInvoiceCommand($invoiceId, Uuid::v7()));
    }
}
```

---

## 2. Behat — configuration (behat.yaml)

```yaml
# behat.yaml
default:
    suites:
        invoicing:
            paths:
                - '%paths.base%/features/invoicing'
            contexts:
                - App\InvoicingBundle\Tests\Behat\Context\InvoicingContext
                - App\Tests\Behat\Context\AuthContext
        workspace:
            paths:
                - '%paths.base%/features/workspace'
            contexts:
                - App\WorkspaceBundle\Tests\Behat\Context\WorkspaceContext
                - App\Tests\Behat\Context\AuthContext
    extensions:
        FriendsOfBehat\SymfonyExtension:
            bootstrap: config/bootstrap.php
```

---

## 3. Behat — FeatureContext pattern

Behat directly reads the `.feature` Gherkin files produced by `sdd-spec-writer`.
The step definitions implement each Given/When/Then step.

```php
<?php
declare(strict_types=1);

namespace App\InvoicingBundle\Tests\Behat\Context;

use App\InvoicingBundle\Application\Command\ArchiveInvoiceCommand;
use App\InvoicingBundle\Domain\Entity\Invoice;
use App\InvoicingBundle\Domain\Repository\InvoiceRepositoryInterface;
use Behat\Behat\Context\Context;
use Behat\Behat\Tester\Exception\PendingException;
use Symfony\Component\Messenger\MessageBusInterface;
use Symfony\Component\Uid\Uuid;

final class InvoicingContext implements Context
{
    private ?Invoice $currentInvoice = null;
    private ?\Throwable $lastException = null;

    public function __construct(
        private readonly InvoiceRepositoryInterface $invoiceRepository,
        private readonly MessageBusInterface $commandBus,
    ) {}

    // -------------------------------------------------------------------------
    // Given steps — set up world state
    // -------------------------------------------------------------------------

    /**
     * @Given a draft invoice :invoiceNumber exists in workspace :workspaceId
     */
    public function aDraftInvoiceExistsInWorkspace(string $invoiceNumber, string $workspaceId): void
    {
        $invoice = Invoice::create($invoiceNumber, Uuid::fromString($workspaceId));
        $this->invoiceRepository->save($invoice);
        $this->currentInvoice = $invoice;
    }

    /**
     * @Given the invoice :invoiceNumber is already archived
     */
    public function theInvoiceIsAlreadyArchived(string $invoiceNumber): void
    {
        if ($this->currentInvoice === null) {
            throw new \RuntimeException('No current invoice in context');
        }
        $this->currentInvoice->archive();
        $this->invoiceRepository->save($this->currentInvoice);
    }

    // -------------------------------------------------------------------------
    // When steps — execute actions
    // -------------------------------------------------------------------------

    /**
     * @When a workspace admin archives the invoice
     */
    public function aWorkspaceAdminArchivesTheInvoice(): void
    {
        try {
            $this->commandBus->dispatch(new ArchiveInvoiceCommand(
                $this->currentInvoice->getId(),
                Uuid::v7(), // admin user ID — substitute with actual auth context
            ));
        } catch (\Throwable $e) {
            $this->lastException = $e;
        }
    }

    // -------------------------------------------------------------------------
    // Then steps — assert outcomes
    // -------------------------------------------------------------------------

    /**
     * @Then the invoice status should be :status
     */
    public function theInvoiceStatusShouldBe(string $status): void
    {
        $invoice = $this->invoiceRepository->findById($this->currentInvoice->getId());
        assert($invoice !== null, 'Invoice not found after operation');
        assert(
            $invoice->getStatus() === $status,
            sprintf('Expected status "%s" but got "%s"', $status, $invoice->getStatus())
        );
    }

    /**
     * @Then an :exceptionClass error should be raised
     */
    public function anErrorShouldBeRaised(string $exceptionClass): void
    {
        assert(
            $this->lastException instanceof $exceptionClass,
            sprintf('Expected %s but got %s', $exceptionClass, get_class($this->lastException ?? new \stdClass()))
        );
    }
}
```

---

## 4. Behat — mapping .feature Scenarios to step definitions

The Gherkin `.feature` files from `sdd-spec-writer` are used **directly** by Behat.
Do not duplicate them.

When the builder generates step definitions, it reads each Gherkin step from the `.feature` and generates a PHP method stub:

```gherkin
# From features/invoicing/invoice-archive.feature

Scenario: Workspace admin archives a draft invoice
    Given a draft invoice "INV-001" exists in workspace "workspace-uuid"
    When a workspace admin archives the invoice
    Then the invoice status should be "archived"

Scenario: Cannot archive an already archived invoice
    Given a draft invoice "INV-001" exists in workspace "workspace-uuid"
    And the invoice "INV-001" is already archived
    When a workspace admin archives the invoice
    Then an "InvoiceAlreadyArchivedException" error should be raised
```

The builder generates one step definition method per unique Gherkin step pattern.
Step patterns are extracted by reading Given/When/Then lines.

---

## 5. PHPUnit configuration (phpunit.xml)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<phpunit xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="vendor/phpunit/phpunit/phpunit.xsd"
         colors="true"
         cacheDirectory=".phpunit.cache"
>
    <php>
        <ini name="display_errors" value="1"/>
        <ini name="error_reporting" value="-1"/>
        <server name="APP_ENV" value="test" force="true"/>
        <server name="SHELL_VERBOSITY" value="-1"/>
    </php>
    <testsuites>
        <testsuite name="Unit">
            <directory>src/*/Tests/Unit</directory>
        </testsuite>
        <testsuite name="Integration">
            <directory>src/*/Tests/Integration</directory>
        </testsuite>
    </testsuites>
    <source>
        <include>
            <directory>src</directory>
        </include>
        <exclude>
            <directory>src/*/Tests</directory>
        </exclude>
    </source>
</phpunit>
```

---

## 6. Test naming conventions

| Type | Class name | File location |
|---|---|---|
| Unit test for handler | `ArchiveInvoiceHandlerTest` | `Tests/Unit/Application/CommandHandler/` |
| Unit test for entity | `InvoiceTest` | `Tests/Unit/Domain/Entity/` |
| Unit test for voter | `InvoiceVoterTest` | `Tests/Unit/Presentation/Security/Voter/` |
| Behat context | `InvoicingContext` | `Tests/Behat/Context/` |
| Shared Behat auth context | `AuthContext` | `Tests/Behat/Context/` |
