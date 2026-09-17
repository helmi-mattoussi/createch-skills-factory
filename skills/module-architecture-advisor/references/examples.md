# Examples

Use these examples to recognize strong Module Architecture Documents and avoid anti-patterns.

---

# Example 1 — Invoicing module (lifecycle entity with state machine)

## Input

- Module definition: invoicing module owns invoice creation, validation, and lifecycle
- .feature coverage: invoice-creation.feature, invoice-archive.feature, invoice-state.feature
- Stack: Symfony 7 / API Platform, PostgreSQL, Doctrine ORM (but do not write ORM config)
- ADR-001: JWT authentication decided
- ADR-002: Row-level workspace isolation decided

## Good Module Architecture Document

```markdown
# Module Architecture: invoicing

## Context
- Module definition: Solution Architecture Map v1
- .feature sources: invoice-creation.feature, invoice-archive.feature, invoice-state.feature
- ADR references: ADR-001 (JWT), ADR-002 (row-level isolation)
- Stack: Symfony 7 / API Platform, PostgreSQL
- Mode: framing

## Module overview

**Responsibility:** owns the full lifecycle of invoices from draft to finalized.

**Boundary:**
- Owns: Invoice, InvoiceLine, invoice state machine
- Does not own: client records (clients module), email delivery (notifications module), user identity (identity module)

**Exposes to other modules:**
- `GET /invoices` — workspace-scoped invoice list
- `POST /invoices/{id}/archive` — archive operation
- Invoice archived event (for notifications module)

---

## Entity model

### Invoice
| Field | Type | Required | Description |
|---|---|---|---|
| id | uuid | yes | unique identifier |
| workspace_id | uuid-ref (→ Workspace) | yes | workspace this invoice belongs to — row isolation |
| client_id | uuid-ref (→ Client) | yes | client reference — resolved from clients module |
| invoice_number | string | yes | unique sequential number within the workspace |
| status | enum (draft, validated, sent, paid, archived) | yes | current lifecycle state |
| issued_at | datetime | no | date the invoice was issued |
| due_at | datetime | no | payment due date |
| subtotal | decimal | yes | total amount before taxes |
| tax_amount | decimal | yes | tax amount |
| total | decimal | yes | total amount including taxes |
| notes | text | no | optional notes visible on the invoice |
| created_at | datetime | yes | technical tracking |
| updated_at | datetime | yes | technical tracking |

**Source:** invoice-creation.feature, invoice-state.feature

### InvoiceLine
| Field | Type | Required | Description |
|---|---|---|---|
| id | uuid | yes | unique identifier |
| invoice_id | uuid-ref (→ Invoice) | yes | parent invoice |
| description | string | yes | line item description |
| quantity | decimal | yes | quantity |
| unit_price | decimal | yes | unit price excluding taxes |
| line_total | decimal | yes | computed: quantity × unit_price |

**Source:** invoice-creation.feature

---

## State machine

### Invoice lifecycle

States:
| State | Meaning |
|---|---|
| draft | invoice is being prepared, not yet visible to client |
| validated | invoice is internally approved, ready to send |
| sent | invoice has been sent to the client |
| paid | payment confirmed |
| archived | invoice removed from active views |

Allowed transitions:
| From | To | Actor | Trigger |
|---|---|---|---|
| draft | validated | workspace member | manually validates |
| validated | sent | workspace member | marks as sent / sends |
| sent | paid | workspace member | records payment |
| draft | archived | workspace admin | archives |
| validated | archived | workspace admin | archives |
| sent | archived | workspace admin | archives |
| paid | archived | workspace admin | archives |

Forbidden transitions:
- archived → any state (restore is out of scope in MVP)
- paid → draft or validated or sent (payment is final)

**Source:** invoice-state.feature, invoice-archive.feature

---

## API contract

### POST /invoices
**Operation:** create a draft invoice
**Actor:** workspace member
**Input:** client_id, lines (description, quantity, unit_price), notes (optional)
**Output:** created invoice with id, invoice_number, status=draft, totals
**Main errors:**
- 403: actor is not a workspace member
- 422: client_id does not exist or does not belong to this workspace
- 422: at least one line is required

**Source:** invoice-creation.feature

---

### PATCH /invoices/{id}
**Operation:** update a draft invoice
**Actor:** workspace member (owner)
**Input:** partial update — lines, notes, client_id
**Output:** updated invoice
**Main errors:**
- 403: actor is not the invoice owner or not a member
- 409: invoice is not in draft status (only drafts are editable)
- 422: client_id not valid

**Source:** invoice-creation.feature

---

### POST /invoices/{id}/archive
**Operation:** archive an invoice
**Actor:** workspace admin
**Input:** none
**Output:** archived invoice with status=archived
**Main errors:**
- 403: actor is not a workspace admin
- 409: invoice is already archived

**Source:** invoice-archive.feature

---

### GET /invoices
**Operation:** list workspace invoices
**Actor:** workspace member
**Input:** none (pagination supported)
**Output:** list of invoices with id, invoice_number, client name, status, total, issued_at
**Main errors:**
- 403: actor is not a workspace member

**Source:** invoice-creation.feature

---

## Service layer structure

### InvoiceCreator
**Responsibility:** creates a new draft invoice, computes line totals and totals, assigns invoice_number
**Not responsible for:** state transitions, archive logic
**Operates on:** Invoice, InvoiceLine
**Depends on:** workspace context (from JWT), client existence validation (clients module)

### InvoiceStateTransitioner
**Responsibility:** manages all invoice state machine transitions and enforces allowed/forbidden rules
**Not responsible for:** creating invoices, line items
**Operates on:** Invoice
**Depends on:** none

### InvoiceArchiver
**Responsibility:** handles the archive transition specifically with workspace-admin permission check
**Not responsible for:** other state transitions
**Operates on:** Invoice
**Depends on:** InvoiceStateTransitioner (delegates state change)

### InvoiceNumberGenerator
**Responsibility:** generates the next sequential invoice number for a workspace
**Not responsible for:** business logic, state
**Operates on:** Invoice (reads max number for workspace)

---

## Architecture patterns applied

| Pattern | Applied to | Reason |
|---|---|---|
| Service layer | all write operations | keeps API resources thin, isolates business logic |
| State machine service | Invoice lifecycle | lifecycle has 5 states and 7 transitions — needs explicit governance |
| Row-level workspace isolation | all queries | ADR-002 — workspace_id on every query |

---

## Module-specific ADR needs

| # | Decision needed | Why it matters | Options | Recommendation |
|---|---|---|---|---|
| ADR-005 | Invoice archive event (sync vs async) | notifications module needs to react | direct call / domain event | direct call for MVP |
| ADR-006 | Invoice PDF generation | sent invoices may need PDF | inline generation / external service | external service (postpone to V2+ if not in MVP .feature) |

---

## Assumptions

- A1: created_at and updated_at are standard technical tracking fields
- A2: soft-archive via status field, no hard delete of invoices
- A3: invoice_number is workspace-scoped sequential (e.g., INV-001 per workspace)

## Needs validation

- D1: permission for PATCH — is it only the original creator or any workspace member?

## Handoff to builders

### May assume
- entities Invoice and InvoiceLine are as defined above
- state machine transitions are as defined, forbidden transitions must be enforced
- 4 services are defined with their responsibilities
- workspace row isolation via workspace_id is applied on all queries (ADR-002)
- API routes are as defined with their input/output shapes

### Must not invent
- additional entity fields without .feature grounding
- new state transitions not in the state machine above
- new services without responsibility justification

### Builder judgment applies to
- PHP class naming conventions
- Symfony resource and provider/processor implementation details
- unit test structure
- code style
```

## Why this is strong

- entity fields are grounded with source references
- state machine is complete with forbidden transitions
- API operations use domain action names and are grounded in .feature
- 4 focused services, each with clear single responsibility
- ADR-006 defers PDF generation rather than inventing it
- D1 Needs validation is honest

---

# Anti-patterns to avoid

Do not produce a Module Architecture Document that:
- defines 15 entity fields where 8 are not in any .feature (field speculation)
- creates an InvoiceManager service responsible for everything
- adds API endpoints not backed by any .feature
- skips the state machine on a lifecycle entity
- does not state what each service is NOT responsible for
- uses framework-specific vocabulary (annotations, attributes, YAML config) instead of architecture language
- over-engineers with CQRS and event sourcing for a simple invoice module
