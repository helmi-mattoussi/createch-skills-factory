# Symfony Stack Reference — Enterprise Safe

## Stack canonique

| Composant | Version contrainte | Raison |
|---|---|---|
| PHP | **8.4** | Dernière stable — property hooks, asymetric visibility, lazy objects |
| Symfony | **7.4.*** | LTS — support jusqu'à novembre 2028 |
| Twig | **3.*** | Stable, compatible Symfony 7.4 |
| Doctrine ORM | **3.6.*** | Dernière branche stable 3.x |
| Doctrine DBAL | **4.*** | Requis par Doctrine ORM 3.6 |
| symfony/ux-turbo | last stable | Hotwire Turbo — navigation sans rechargement |
| symfony/stimulus-bundle | last stable | Stimulus.js — contrôleurs JS légers |
| Symfony AssetMapper | built-in 7.4 | Remplace Webpack Encore — import maps natif |
| PHPUnit | **11.x** | Compatible PHP 8.4 + Symfony 7.4 |
| Behat | **3.x** | BDD — lit directement les .feature Gherkin |
| Zenstruck Foundry | **2.x** | Factories pour fixtures de test |

---

## Pourquoi Symfony 7.4 LTS

- **LTS = Long Term Support** : corrections de sécurité garanties jusqu'à novembre 2028
- Choisir 7.4 plutôt que 7.2 ou 8.0 pour les projets qui seront en production plusieurs années
- Migration future : Symfony 8.0 ne gardera que ce qui est dans 7.4 → démarrer sur 7.4 facilite la migration

## Pourquoi PHP 8.4

- **Property hooks** : `public string $name { get => ...; set => ...; }` — DTOs plus expressifs
- **Asymmetric visibility** : `public private(set) string $id` — entités DDD plus robustes
- **Lazy objects** : améliorations de performance sur les services Symfony
- **`#[\Deprecated]`** : attribut officiel PHP pour marquer les éléments obsolètes

---

## Requirements composer.json

```json
{
    "require": {
        "php": "^8.4",
        "symfony/framework-bundle": "7.4.*",
        "symfony/twig-bundle": "7.4.*",
        "symfony/asset-mapper": "7.4.*",
        "symfony/asset": "7.4.*",
        "symfony/security-bundle": "7.4.*",
        "symfony/messenger": "7.4.*",
        "symfony/workflow": "7.4.*",
        "symfony/form": "7.4.*",
        "symfony/validator": "7.4.*",
        "symfony/http-client": "7.4.*",
        "doctrine/doctrine-bundle": "^2.13",
        "doctrine/orm": "^3.6",
        "doctrine/dbal": "^4.0",
        "doctrine/doctrine-migrations-bundle": "^3.4",
        "symfony/uid": "7.4.*",
        "symfony/ux-turbo": "*",
        "symfony/stimulus-bundle": "*"
    },
    "require-dev": {
        "symfony/maker-bundle": "*",
        "doctrine/doctrine-fixtures-bundle": "^3.7",
        "phpunit/phpunit": "^11.0",
        "symfony/phpunit-bridge": "7.4.*",
        "behat/behat": "^3.14",
        "friends-of-behat/symfony-extension": "^2.4",
        "zenstruck/foundry": "^2.0",
        "symfony/browser-kit": "7.4.*",
        "symfony/css-selector": "7.4.*"
    }
}
```

---

## Installation depuis un Starter Kit ou Zéro

La méthode recommandée est de cloner le Starter Kit de l'entreprise qui embarque déjà la stack approuvée (Auth, Tailwind, UX).

**Option A : Via Corporate Starter Kit (RECOMMANDÉ)**
```bash
# S'il n'y a pas encore de répertoire de travail
git clone https://github.com/votre-org/symfony-b2b-starter.git .
composer install
npm install
```

**Option B : Installation pure depuis zéro (FRAMEWORK ONLY)**
*À n'utiliser que si aucun Starter n'est prescrit.*
```bash
# Créer le projet Symfony 7.4 LTS
composer create-project symfony/skeleton:"7.4.*" my-project
cd my-project

# Bundles applicatifs (selon architecture)
composer require symfony/twig-bundle symfony/asset-mapper symfony/asset symfony/security-bundle
# Uniquement si prescrit :
# composer require symfony/messenger symfony/workflow
composer require symfony/form symfony/validator
composer require doctrine/orm:"^3.6" doctrine/dbal:"^4" doctrine/doctrine-bundle doctrine/doctrine-migrations-bundle
composer require symfony/uid
composer require symfony/ux-turbo symfony/stimulus-bundle
```

# Dev tools
composer require --dev symfony/maker-bundle
composer require --dev doctrine/doctrine-fixtures-bundle
composer require --dev "phpunit/phpunit:^11" symfony/phpunit-bridge symfony/browser-kit symfony/css-selector
composer require --dev "behat/behat:^3.14" "friends-of-behat/symfony-extension:^2.4"
composer require --dev "zenstruck/foundry:^2.0"

# Tailwind CSS v4 via npm
npm install tailwindcss@next @tailwindcss/vite
```

---

## PHP 8.4 patterns dans le code généré

### Property hooks (pour les Value Objects)

```php
// PHP 8.4 — plus besoin de getters manuels pour des propriétés simples
class InvoiceNumber
{
    public string $value {
        get => $this->value;
        set(string $v) {
            if (!preg_match('/^INV-\d{4}-\d+$/', $v)) {
                throw new \InvalidArgumentException("Invalid invoice number: $v");
            }
            $this->value = $v;
        }
    }

    public function __construct(string $value) {
        $this->value = $value; // passe par le setter hook
    }
}
```

### Asymmetric visibility (pour les entités DDD)

```php
// PHP 8.4 — propriétés lisibles publiquement, non modifiables de l'extérieur
class Invoice
{
    public private(set) Uuid $id;
    public private(set) string $status;
    public private(set) \DateTimeImmutable $createdAt;

    public function __construct()
    {
        $this->id = Uuid::v7();
        $this->status = InvoiceStatus::DRAFT->value;
        $this->createdAt = new \DateTimeImmutable();
    }

    // Comportement métier : seul le code interne de la classe modifie $status
    public function archive(): void
    {
        if ($this->status === InvoiceStatus::ARCHIVED->value) {
            throw new InvoiceAlreadyArchivedException($this->id);
        }
        $this->status = InvoiceStatus::ARCHIVED->value;
    }
}
```

### PHP 8.1+ Enums (pour les états simples)

```php
enum InvoiceStatus: string
{
    case DRAFT = 'draft';
    case VALIDATED = 'validated';
    case SENT = 'sent';
    case PAID = 'paid';
    case ARCHIVED = 'archived';

    public function canTransitionTo(self $next): bool
    {
        return match ($this) {
            self::DRAFT => in_array($next, [self::VALIDATED, self::ARCHIVED]),
            self::VALIDATED => in_array($next, [self::SENT, self::ARCHIVED]),
            self::SENT => in_array($next, [self::PAID, self::ARCHIVED]),
            self::PAID => $next === self::ARCHIVED,
            self::ARCHIVED => false,
        };
    }
}
```

---

## AssetMapper configuration (Symfony 7.4)

```yaml
# config/packages/asset_mapper.yaml
framework:
    asset_mapper:
        paths:
            - assets/
        missing_import_mode: warn
```

```javascript
// assets/app.js
import './bootstrap.js';
import './styles/app.css';
import '@hotwired/turbo';
import { startStimulusApp } from '@symfony/stimulus-bundle';

const app = startStimulusApp();
// Les contrôleurs dans assets/controllers/ sont auto-découverts
```

```css
/* assets/styles/app.css */
@import "tailwindcss";

@theme {
    --color-brand-500: oklch(55% 0.18 260);
    --color-brand-600: oklch(48% 0.18 260);
    --font-sans: 'Inter', system-ui, sans-serif;
}
```

---

## Messenger configuration (Symfony 7.4)

```yaml
# config/packages/messenger.yaml
framework:
    messenger:
        failure_transport: failed
        transports:
            async:
                dsn: '%env(MESSENGER_TRANSPORT_DSN)%'
                retry_strategy:
                    max_retries: 3
                    multiplier: 2
            failed:
                dsn: 'doctrine://default?queue_name=failed'
        routing:
            # Par défaut : tout est synchrone
            # Ajouter les events à router en async selon les ADR du projet
            # Exemple:
            # App\InvoicingBundle\Domain\Event\InvoiceArchived: async
```

---

## Doctrine ORM 3.6 — Symfony 7.4 configuration

```yaml
# config/packages/doctrine.yaml
doctrine:
    dbal:
        url: '%env(resolve:DATABASE_URL)%'
        # DBAL 4 : PostgreSQL recommandé pour les projets SaaS
    orm:
        auto_generate_proxy_classes: true
        enable_lazy_ghost_objects: true    # PHP 8.4 lazy objects natifs
        naming_strategy: doctrine.orm.naming_strategy.underscore_number_aware
        auto_mapping: true
        mappings:
            # Un mapping par module, ajouté ici au fur et à mesure
            App:
                is_bundle: false
                dir: '%kernel.project_dir%/src'
                prefix: 'App'
                alias: App
```

---

## Symfony Security 7.4 configuration (référence)

```yaml
# config/packages/security.yaml
security:
    password_hashers:
        Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface: 'auto'
    providers:
        app_user_provider:
            entity:
                class: App\Identity\Domain\Entity\User
                property: email
    firewalls:
        dev:
            pattern: ^/(_(profiler|wdt)|css|images|js)/
            security: false
        main:
            lazy: true
            provider: app_user_provider
            form_login:
                login_path: app_login
                check_path: app_login
                enable_csrf: true
            logout:
                path: app_logout
    access_control:
        - { path: ^/login, roles: PUBLIC_ACCESS }
        - { path: ^/, roles: ROLE_USER }
```

---

## Services autowiring convention

```yaml
# src/<Module>/Resources/config/services.yaml
# OU src/<Module>/config/services.yaml selon la structure prescrite
services:
    _defaults:
        autowire: true
        autoconfigure: true
        bind:
            # Binding explicite pour les interfaces
            App\Invoicing\Domain\Repository\InvoiceRepositoryInterface:
                '@App\Invoicing\Infrastructure\Persistence\DoctrineInvoiceRepository'

    App\Invoicing\:
        resource: '../../*'
        exclude:
            - '../../Domain/Entity'
            - '../../Domain/Event'
            - '../../Domain/ValueObject'
            - '../../Domain/Exception'
            - '../../Tests'
```

---

## Contraintes de compatibilité — règles de génération

| Règle | Raison |
|---|---|
| Utiliser `#[ORM\Entity]` attributs PHP uniquement | Doctrine DBAL 4 + ORM 3.6 — plus de YAML ou XML mapping |
| Utiliser `Uuid::v7()` pour les IDs | Symfony UID 7.4 — v7 est trié par temps, meilleur pour Doctrine |
| Utiliser `readonly` classes pour les Commands/DTOs | PHP 8.4 — immuabilité native |
| Utiliser `AsMessageHandler` attribut | Symfony Messenger 7.4 — pas de `HandleMessageInterface` |
| Utiliser `#[Route]` attribut | Symfony Router 7.4 — pas d'annotation Doctrine |
| Utiliser `#[IsGranted]` attribut | Symfony Security 7.4 — intégration Voter directe |
| Ne pas utiliser `@var` annotations | PHP 8.4 types natifs uniquement |
| Utiliser `declare(strict_types=1)` | Requis sur tous les fichiers PHP |
