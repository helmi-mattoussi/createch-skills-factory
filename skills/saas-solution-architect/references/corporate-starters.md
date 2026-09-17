# Corporate Starter Kits

Pour accélérer la création de valeur et standardiser les architectures, l'organisation s'appuie sur des "Starter Kits". Ces socles pré-configurés embarquent déjà les modules transverses (infrastructurel, sécurité, utilitaires) pour que les équipes produit se concentrent uniquement sur la logique métier.

En tant que `saas-solution-architect`, vous **devez** vérifier si un Starter Kit est prescrit pour le projet. S'il l'est, vous ne devez **pas** concevoir l'architecture interne des modules déjà fournis par le starter (sauf besoin d'extension spécifique). Vous devez simplement les lister dans la Solution Architecture Map comme `[Provided by Starter Kit]`.

---

## 1. Symfony B2B SaaS Starter (`createch/symfony-b2b-starter`)

**Cas d'usage :** Applications web monolithiques rendues côté serveur avec Twig/Turbo/Stimulus.

**Modules natifs inclus (Provided by Starter) :**
- **Identity / Auth Module :** Gestion des entités `User`, login, mot de passe oublié, rôles (RBAC de base), Two-Factor Authentication (2FA).
- **Notification Module :** Envoi d'emails (via Symfony Mailer) et templates d'emails de base intégrés, asynchrone via Messenger.
- **AuditLog / Telemetry Module :** Observabilité (Monolog JSON, Trace IDs), Health checks (`/healthz`), et hooks Doctrine pour historiser les changements des entités (Audit Trail).
- **Media Module :** Abstraction de stockage et génération d'URL sécurisées pour les fichiers uploadés.
- **UI System :** Configuration Tailwind v4 + AssetMapper + composants métier de base Twig/Stimulus.

**Ce que l'architecte doit faire :** Ne pas recréer de module `Identity` sauf comportement très spécifique. Brancher les autres modules (ex: `Invoicing`) directement sur le `User` existant.

---

## 2. API Platform Headless Starter (`createch/api-headless-starter`)

**Cas d'usage :** Backends purement API (REST/GraphQL) pour applications mobiles ou Single Page Applications (SPA).

**Modules natifs inclus :**
- **Security / JWT Module :** Authentification par Token JWT (LexikJWTAuthenticationBundle), endpoints d'auth générés.
- **Identity Module :** Utilisateur minimal API.
- **Media Module :** Point d'entrée pour l'upload et le stockage de fichiers (S3/Local).

---

## 3. Angular Enterprise Workspace (`createch/angular-enterprise-starter`)

**Cas d'usage :** Frontends complexes (SPA) d'entreprise.

**Modules natifs inclus :**
- **AuthFlow Module :** Intercepteurs JWT, Auth Guards, page de login pré-câblée avec l'API.
- **Design System lib :** Bibliothèque de composants UI (boutons, tables, modales) basée sur Tailwind.
- **State Management :** Structure de store (NgRx ou Signals) incluant la gestion d'erreurs globales.

---

## Instructions pour la Solution Architecture Map

Quand vous rédigez le document d'architecture globale, ajoutez la section :
`**Foundation Strategy:** Uses createch/symfony-b2b-starter`

Dans la définition des modules, marquez-les ainsi :
- `Identity` -> Responsibility: User login & roles | Status: **[Provided by Starter]**
- `Billing` -> Responsibility: Invoice lifecyle | Status: **[To be built]**
