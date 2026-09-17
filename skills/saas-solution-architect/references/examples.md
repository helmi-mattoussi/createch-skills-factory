# Examples

Use these examples to recognize strong Solution Architecture Map patterns and common anti-patterns.

---

# Example 1 — New SaaS product with invoicing and workspace management

## Input (Product Framing Dossiers)

- PFD-01: workspace members can create and manage invoices for their clients
- PFD-02: workspace admins can invite and manage team members
- Technology stack: Symfony 7 (API Platform), Angular 19, PostgreSQL, Docker

## Good Solution Architecture Map output

```markdown
# Solution Architecture Map: InvoSaaS MVP

## Context
- Framing sources: PFD-01 (invoicing), PFD-02 (workspace)
- Technology stack: Symfony 7 / API Platform, Angular 19, PostgreSQL, Docker
- Date: 2026-03-15

## Capability map

| Capability | Description |
|---|---|
| Workspace management | Create and manage workspaces and team memberships |
| Identity | Authenticate users, manage sessions and tokens |
| Invoicing | Create, edit, validate, and manage invoice lifecycle |
| Client management | Manage client records used in invoices |
| Notifications | Send email notifications for key events |

## Module map

| Module | Responsibility | Phase |
|---|---|---|
| identity | Owns authentication, user accounts, and session management | MVP |
| workspace | Owns workspace creation, membership, and team roles | MVP |
| invoicing | Owns invoice creation, validation, and lifecycle states | MVP |
| clients | Owns client records and their use in invoicing | MVP |
| notifications | Owns email delivery for key domain events | MVP |
| reporting | Owns invoice analytics and revenue reporting | V2+ |

## Module definitions

### identity

**Responsibility:**
Manages user identity, authentication, and session lifecycle for all workspace members.

**Owns:**
- user account (email, password hash, verified status)
- authentication tokens (JWT or session)
- password reset flow

**Does not own:**
- workspace role (that belongs to the workspace module)
- invoice access permissions (derived from workspace role, not identity)

**Exposes to other modules:**
- authenticated user identity (user ID, email)

**Phase:** MVP

**Notes for module-architecture-advisor:**
Auth strategy is pending ADR. JWT vs session-based must be decided. If multi-tenancy is required, token payload must carry workspace context.

---

### workspace

**Responsibility:**
Manages workspace creation, membership, and role assignment for workspace members.

**Owns:**
- workspace entity (name, slug, status)
- workspace membership (user-workspace association, role)
- invitation flow

**Does not own:**
- user identity (belongs to identity module)
- invoice data (belongs to invoicing module)

**Exposes to other modules:**
- workspace membership and role for a given user

**Phase:** MVP

**Notes for module-architecture-advisor:**
Role model (admin / member / read-only) must be clarified before designing the API. Workspace-scoped filtering must be enforced at API level.

---

### invoicing

**Responsibility:**
Owns the full lifecycle of invoices from draft to finalized.

**Owns:**
- invoice entity (number, client reference, line items, total, status)
- invoice state machine (draft → validated → sent → paid → archived)
- line item creation and calculation

**Does not own:**
- client records (belongs to the clients module)
- email delivery (belongs to notifications)
- payment processing

**Exposes to other modules:**
- invoice status change events (for notifications)

**Phase:** MVP

**Notes for module-architecture-advisor:**
State machine logic is the most complex part of this module. Allowed transitions must be explicitly governed. Archive and restore behavior must be specified in .feature before designing.

---

### clients

**Responsibility:**
Manages the client records used as recipients of invoices.

**Owns:**
- client entity (name, email, billing address, VAT number)
- client status (active / archived)

**Does not own:**
- invoice data (belongs to invoicing)
- contact communication history

**Exposes to other modules:**
- client data for invoice creation

**Phase:** MVP

**Notes for module-architecture-advisor:**
Client data is referenced from invoicing. Decide whether client deletion is allowed when invoices reference the client.

---

### notifications

**Responsibility:**
Delivers email notifications for key domain events from other modules.

**Owns:**
- email template management
- delivery queue and retry logic
- delivery status tracking

**Does not own:**
- the domain events that trigger notifications (owned by invoicing and workspace)

**Exposes to other modules:**
- notification trigger API (or listens to domain events)

**Phase:** MVP

**Notes for module-architecture-advisor:**
Sync vs async triggering must be decided (ADR). If event-driven, an event bus or queue is required. Start with sync for MVP if event bus is not yet available.

---

## Dependency map

### Module dependencies

| Module | Depends on | Nature |
|---|---|---|
| workspace | identity | resolves authenticated user for membership |
| invoicing | identity | resolves authenticated workspace member |
| invoicing | clients | reads client record for invoice creation |
| invoicing | workspace | enforces workspace-scoped access |
| notifications | invoicing | triggered by invoice events |
| notifications | workspace | triggered by membership events |

### External dependencies

| External system | Used by | Nature |
|---|---|---|
| Email provider (TBD) | notifications | transactional email delivery |

## MVP delivery boundary

### In MVP
- identity: foundational — no other module works without it
- workspace: foundational — scopes all data and access
- invoicing: core product value
- clients: required for invoicing
- notifications: required for invitation and invoice delivery

### In V2+
- reporting: not required to validate core invoice flow

## Macro delivery order (MVP)

1. identity (foundational — blocks everything else)
2. workspace (foundational — required before any scoped module)
3. clients (required before invoicing can create invoices)
4. invoicing (core product value)
5. notifications (cross-cutting, buildable after core modules are stable)

## Required ADR decisions

| # | Decision needed | Why it matters | Options | Recommendation |
|---|---|---|---|---|
| ADR-001 | Authentication strategy | Affects token payload, workspace context propagation | JWT stateless / session-based | JWT if multi-workspace context is needed |
| ADR-002 | Data isolation model | Affects SQL schema, query patterns throughout | Row-level security / schema-per-tenant | Row-level security for MVP simplicity |
| ADR-003 | Notification trigger pattern | Affects module coupling (sync vs async) | Direct call / domain events | Direct call for MVP, events for V2+ |
| ADR-004 | Email provider selection | Affects notifications module integration | Mailjet / Sendgrid / Postmark / custom | Any transactional provider with API |

## Architecture assumptions

- A1: monolith-compatible module structure assumed (single Symfony application with module-namespaced code)
- A2: PostgreSQL used for all modules unless ADR defines otherwise
- A3: standard REST API assumed pending ADR on API style

## Needs validation

- D1: multi-tenancy model must be confirmed before ADR-001 and ADR-002 can be finalized
```

## Why this is strong

- every module has one clear responsibility
- "Does not own" sections prevent coupling
- notes for module-architecture-advisor are specific and useful
- required ADRs are concrete and actionable
- MVP boundary is disciplined with explicit justification
- delivery order reflects actual technical dependencies

---

# Anti-patterns to avoid

Do not produce a Solution Architecture Map that:
- names modules after technical layers (controller, service, repository)
- mixes module internals (class names, method names) into the map
- has modules without "does not own" boundaries
- has a bloated MVP that includes everything
- has no ADR list (all cross-cutting decisions are somehow resolved)
- uses vague module names like "utils", "core", or "shared"
- creates circular dependencies without surfacing them
- defines 20 micro-modules for a 5-capability product
