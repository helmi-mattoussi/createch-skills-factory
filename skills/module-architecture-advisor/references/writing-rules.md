# Writing Rules

This document defines the writing discipline for Module Architecture Documents.

---

# Core principle

A Module Architecture Document describes **what the module is made of and how its parts work**, not how to code it.

It must operate at:
- entity and field level (not table and column level)
- service and responsibility level (not class and method level)
- API operation and contract level (not framework decorator level)

It must not include:
- PHP classes, namespaces, or annotations/attributes
- Doctrine mappings or ORM configurations
- Symfony service configuration YAML
- Angular component or service code
- SQL table definitions

---

# Domain vocabulary for entities

Entity names use domain vocabulary (PascalCase for names in text).

Good:
- `Invoice`, `WorkspaceMember`, `Client`, `InvitationToken`

Bad:
- `InvoiceDto`, `UserEntity`, `WorkspaceTable`, `InvoiceOrm`

Entity field names should match how they appear in the `.feature` or product framing (not database column names).

Good:
- `invoice_number`, `billing_address`, `issued_at`

Bad:
- `invoice_num_col`, `addr_str`, `ts_issue`

---

# Service names — single responsibility

Service names should be action-oriented and specific.

Good:
- `InvoiceArchiver` — archives invoices
- `MemberInvitationSender` — sends and validates workspace invitations
- `InvoiceStateTransitioner` — manages invoice state machine transitions

Bad:
- `InvoiceManager` — too broad, implies managing everything
- `WorkspaceService` — too broad, implies the whole workspace domain
- `Helper` — no responsibility indicated

Each service name should make its single responsibility obvious.

---

# API routes — domain actions, not generic CRUD

Good:
- `POST /invoices/{id}/archive`
- `POST /workspace/members/invite`
- `POST /invoices/{id}/mark-sent`

Bad:
- `PATCH /invoices/{id}` for archiving (too generic)
- `PUT /users/{id}` for updating workspace role (hides the action)

Use HTTP verbs correctly:
- POST for state-changing actions and creation
- GET for reads
- PUT/PATCH for updates
- DELETE for deletion

---

# State machine precision

State names should be operational, not implementation artifacts.

Good:
- `draft`, `validated`, `sent`, `paid`, `archived`

Bad:
- `state_0`, `STATUS_DRAFT`, `isArchived=true`

Transition descriptions should clearly name the triggering actor and action.

Good:
- "workspace admin selects archive → archived"
- "billing member submits invoice for payment → sent"

---

# Field descriptions

Field descriptions should be short and operational.

Good:
- "total amount excluding taxes"
- "date the invoice was sent to the client"
- "unique sequential invoice number in the workspace"

Bad:
- "the amount"
- "date field"
- "number"

---

# Assumptions vs confirmed elements

Distinguish clearly:

**Confirmed** (grounded in .feature or ADR or PD-*):
- state it with its source
- "invoice_number: unique sequential number (source: invoice-creation.feature)"

**Assumption** (conservative technical choice, not in any .feature):
- "A1: created_at and updated_at are assumed as standard technical tracking fields"
- "A2: soft-delete flag is_archived is assumed rather than hard delete, for data integrity"

**Needs validation** (cannot be resolved alone):
- "D1: permission enforcement strategy for archive (service layer vs API layer) must be decided (ADR)"

---

# Over-engineering discipline

At every design decision, ask:
- does a validated `.feature` scenario require this?
- would a builder be blocked without it?
- is a simpler design sufficient?

If the answer to the third question is yes, go simpler.

The goal is not an elegant architecture.
The goal is the minimum architecture that correctly implements all validated behaviors.
