# Architecture Output Template

Use this template when creating a Solution Architecture Map.

The goal is not to fill every section mechanically.
The goal is to produce a map that:
- clearly identifies all modules and their boundaries
- phases delivery realistically
- identifies technical decisions still pending
- gives module-architecture-advisor a grounded starting point per module

---

# Recommended template

```markdown
# Solution Architecture Map: <product or capability set name>

## Context
- Product framing sources: <list of Product Framing Dossiers used>
- Feature specs used: <list of .feature files if available>
- Technology stack: <languages, frameworks, deployment context>
- Date: <date>

## Capability map

High-level product capabilities covered by this architecture:

| Capability | Description |
|---|---|
| <capability 1> | <one-line description> |
| <capability 2> | <one-line description> |

## Module map

| Module | Responsibility | Phase |
|---|---|---|
| <module-name> | <what this module owns in one sentence> | MVP / V2+ |

## Module definitions

### <module-name>

**Responsibility:**
<one paragraph describing what this module owns>

**Owns:**
- <data entity or behavior 1>
- <data entity or behavior 2>

**Does not own:**
- <what belongs to another module>

**Exposes to other modules:**
- <API or event or shared contract>

**Phase:** MVP / V2+

**Notes for module-architecture-advisor:**
<what this module will need to decide at module level>

---

[repeat for each module]

## Dependency map

### Module dependencies

| Module | Depends on | Nature |
|---|---|---|
| <module A> | <module B> | reads data / triggers event / calls API |

### External dependencies

| External system | Used by module(s) | Nature |
|---|---|---|
| <external service> | <module name> | auth / email / storage / payment / etc. |

## MVP delivery boundary

### In MVP
- Module: <name> — reason: <core product value>
- Module: <name> — reason: <foundational infrastructure>

### In V2+
- Module: <name> — reason: <not required to validate core value>
- Capability: <name> — reason: <dependent on MVP learnings>

## Macro delivery order (MVP)

Recommended delivery sequence within MVP:

1. <foundational module(s)>
2. <core capability module(s)>
3. <user-facing module(s) that depend on 1 and 2>
4. <cross-cutting concerns if not in 1>

## Required ADR decisions

| # | Decision needed | Why it matters | Options | Recommendation |
|---|---|---|---|---|
| ADR-001 | <decision topic> | <consequence if undecided> | A / B | <conservative recommendation if any> |

## Architecture assumptions

- A1: <assumption made about technology or structure>
- A2: <assumption made>

## Needs validation

- D1: <architecture decision that requires explicit team validation>
- D2: <constraint that requires product or technical stakeholder input>
```

---

# Section-by-section guidance

## Capability map

Keep this short.
One line per capability.
Use product vocabulary, not technical vocabulary.

## Module map

Each module should be nameable in one word or a short compound (e.g., `invoicing`, `workspace`, `billing`, `identity`, `notifications`).

Each module responsibility must fit in one sentence.
If you cannot state it in one sentence, the module is either too broad or not well-bounded.

## Module definitions

This is the most important section.

The "Does not own" sub-section is critical.
Unclear module ownership is the most common source of duplication, coupling, and architectural drift.

The "Notes for module-architecture-advisor" sub-section should give the next skill enough context to start immediately.

## Dependency map

Direction matters.
A depends on B means A calls, reads, or listens to B.
B does not call A in the other direction (unless explicitly stated).

Circular dependencies must be named and resolved or flagged.

## MVP delivery boundary

Be disciplined about MVP.
The temptation to put everything in MVP is universal and always wrong.

A useful MVP includes:
- the core user journey that proves the product concept
- the foundational modules that everything else depends on
- the minimum infrastructure needed to run reliably

A useful MVP excludes:
- optimization and performance features
- secondary actor features
- reporting and analytics
- administrative tooling (unless it is the core product)
- complex edge cases and exception flows

## Required ADR decisions

List only genuine architecture decisions, not implementation details.

Good ADR candidates:
- auth strategy (JWT vs session, OAuth provider choice)
- data isolation strategy (multi-tenant schema vs database)
- event-driven vs synchronous communication between modules
- external service selection (email provider, storage, payment)
- infrastructure deployment model (serverless vs containerized)
- caching strategy (in-memory vs distributed)
- API contract style (REST vs GraphQL vs RPC)

Not good ADR candidates:
- which controller class to use
- how to name a method
- what variable name to pick

---

# Anti-patterns

Do not produce a Solution Architecture Map that:
- maps every feature to its own micro-module (over-decomposition)
- puts all features into a single "system" module (no decomposition)
- defines module internals (class structure, service names, ORM mapping)
- skips the MVP delivery boundary
- omits the dependency map
- treats all ADR decisions as already resolved
- uses framework vocabulary instead of domain vocabulary as module names
