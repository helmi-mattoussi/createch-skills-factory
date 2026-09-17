# Writing Rules

This document defines the writing discipline for Solution Architecture Maps.

---

# Core principle

A Solution Architecture Map describes **what the solution is composed of and how those parts relate**, not how to implement each part.

It must focus on:
- modules and their responsibilities
- module boundaries (what each module owns and does not own)
- dependencies between modules and external systems
- delivery phasing
- decisions still pending

It must not include:
- class structure or service names
- ORM mapping or table schema
- API endpoint design
- code patterns or framework-specific decisions

---

# Domain vocabulary, not technical vocabulary

Always use business domain vocabulary for module names.

Good:
- `invoicing`
- `workspace`
- `identity`
- `notifications`
- `billing`
- `reporting`

Bad:
- `InvoiceController`
- `UserService`
- `DatabaseLayer`
- `ApiModule`
- `CoreBundle`

The modules in the map should be recognizable to a product owner, not just a developer.

---

# One responsibility per module

Every module must have exactly one clear responsibility.

A responsibility fits in one sentence.
If it requires two sentences, the module is probably doing two things.

Good:
"The invoicing module owns the creation, validation, and lifecycle of invoices."

Bad:
"The invoicing module manages invoices, handles user authentication, and sends email notifications."
(three responsibilities → three modules or shared modules needed)

---

# Boundary precision

The "Does not own" section of each module definition is as important as the "Owns" section.

Write it explicitly.

Good:
```
Invoicing does not own:
- user identity (that is the identity module)
- email delivery (that is the notifications module)
- payment processing (that is the billing module)
```

Do not leave boundaries implicit.
Implicit boundaries always become coupling problems.

---

# Dependency direction

When describing dependencies, be directional.

Use:
- "invoicing depends on identity (for actor authentication)"
- "notifications depends on invoicing (it listens to invoice events)"

Do not use:
- "invoicing and identity are connected"
- "invoicing and notifications interact"

Direction matters for implementation sequencing and testing.

---

# MVP discipline

The MVP boundary section must be decisive.

Do not use:
- "maybe in MVP"
- "could be useful to include"
- "might be needed"

Use:
- "in MVP — required for core purchase flow"
- "in V2+ — not needed to validate the core value"

If the MVP decision is genuinely uncertain, mark it as Needs validation.
Do not silently expand MVP.

---

# ADR naming

When listing required ADR decisions, use action-oriented names.

Good:
- "Decide: authentication strategy (JWT vs session, internal vs external provider)"
- "Decide: data isolation model (row-level security vs schema-per-tenant)"

Bad:
- "Architecture needs to be decided"
- "Technical stuff is pending"

---

# Macro delivery order

Keep the delivery order simple.

A numbered list is sufficient.
No Gantt charts needed.

Good:
```
1. Identity and workspace (foundational)
2. Core invoicing (main product capability)  
3. Billing integration (required for monetization)
4. Notifications (cross-cutting, after core is stable)
```

Bad:
- multi-week sprint plans
- resource allocations
- parallel track dependency graphs

---

# Assumptions vs decisions

Distinguish clearly:

**Assumptions** (the skill made a conservative choice):
- "A1: monolith-compatible module structure assumed because no ADR defines otherwise"
- "A2: standard REST API assumed for module contracts pending ADR on API style"

**Needs validation** (must be explicitly decided):
- "D1: data isolation model must be decided before invoicing module design"
- "D2: auth strategy must be decided before identity module design"

Do not present a Needs validation item as an assumption.
