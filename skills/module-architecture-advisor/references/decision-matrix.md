# Decision Matrix

This document provides a decision framework for recurring situations during module architecture design or refactoring.

---

# Core rule

Priority order:
1. protect the validated behavioral contract from `.feature` files
2. protect module boundary from `saas-solution-architect`
3. apply the minimal sufficient architecture (not the most impressive one)
4. surface decisions rather than making them unilaterally when risk is high

---

# Matrix

| Situation | Risk level | Expected behavior | Output pattern |
|---|---|---|---|
| Module is well-scoped with complete .feature coverage | Low | Design normally | Module Architecture Document |
| Standard CRUD entity with simple lifecycle | Low | Apply standard entity pattern | entity model |
| Service decomposition is obvious from .feature | Low | Apply directly | service layer structure |
| A common well-established pattern clearly fits | Low | Apply it and note it | pattern + justification |
| A field is implied but not in any .feature | Medium | Note as assumption, mark source | entity field + assumption |
| Service boundary is ambiguous between two services | Medium | Assign to the most logical service, state what it does not own | service definition with boundary |
| State machine has an implied state not in .feature | Medium | Keep it out of the confirmed model, note as V2+ or Needs validation | state machine partial |
| Performance concern is implied by scale or volume | Medium | Note concern, propose conservative pattern, mark ADR need | ADR need |
| API operation not grounded in any .feature | Medium to high | Do not include it | out-of-scope note |
| Entity field requires a decision affecting other modules | High | Surface it, mark as Needs validation | module boundary issue |
| Security-sensitive permission enforcement is unclear | High | Design most restrictive default, mark ADR need | ADR need + conservative design |
| Caching strategy is performance-critical | High | Mark as ADR need, note implications | ADR need |
| Cross-module event vs synchronous call is undecided | High | Apply synchronous conservatively, mark ADR need | ADR need |
| Refactor would change validated behavioral contract | High | Do not change behavior, restructure only internal structure | refactor plan without behavioral change |
| Module needs a state machine but transitions are partially unspecified | High | Confirm only .feature-grounded transitions, mark rest as V2+ | partial state machine + Needs validation |
| Technology stack diverges from project ADR | High | Surface conflict, do not override ADR unilaterally | conflict surfaced + escalation |
| Over-engineering pressure (microservices, event sourcing without need) | High | Apply minimal sufficient architecture | simpler design with justification |

---

# Fast decision rules

## Rule 1 — Minimal sufficient architecture

The simplest architecture that satisfies the validated behavioral contract is the right architecture.

Do not add:
- services not needed by any `.feature`
- patterns not needed by the module complexity
- entities not referenced in any `.feature` or PD-*
- API endpoints not backed by a `.feature` operation

If you can implement all validated behaviors with 4 services, do not design 9.

---

## Rule 2 — .feature files are the behavioral authority

Every entity field, every API endpoint, every state transition must be traceable to:
- a validated `.feature` scenario
- a PD-*
- or an explicit well-justified technical necessity (e.g., created_at, updated_at)

If it cannot be traced, it is an assumption and must be labeled as such.

---

## Rule 3 — Module boundary from saas-solution-architect must be respected

Do not absorb entities or services that belong to another module.

When a module needs data from another, design the dependency:
- does it call another module's API?
- does it listen to an event?
- does it receive the ID and resolve via the other module?

Do not duplicate entity ownership across modules.

---

## Rule 4 — State machine transitions must be grounded

Only confirm:
- states explicitly named in a `.feature` scenario
- transitions explicitly described in a `.feature` or PD-*

If a transition is implied but not specced, mark as V2+ or Needs validation.

---

## Rule 5 — Security-sensitive design always needs explicit validation

Do not make the following decisions unilaterally:
- row-level security enforcement approach
- visibility of sensitive data per role
- permission-checking strategy (in service layer vs API layer vs database)
- audit logging requirements

These are ADR needs.

---

# Output chooser

## Output: Complete Module Architecture Document
When:
- module is clearly bounded
- .feature coverage is complete
- technology stack is known
- no blocking ADR need

## Output: Module Architecture Document + ADR list
When:
- most architecture is groundable
- some module-specific decisions are still pending
- design can proceed without locking undecided elements

## Output: Partial Module Architecture Document + Needs validation
When:
- one or two design decisions are genuinely open
- partial useful architecture exists
- rest depends on a product or architecture decision

## Output: Architecture readiness note — not ready
When:
- .feature coverage is insufficient to ground the entity model or API
- module definition is incomplete
- required ADR decisions prevent any grounded design

---

# Escalation chooser

| If the issue is mainly about... | Escalate toward... |
|---|---|
| missing .feature for a behavior | `sdd-spec-writer` |
| unclear module boundary | `saas-solution-architect` |
| sensitive permission or security design | `security-compliance-guardian` |
| performance or scalability risk | `performance-scalability-advisor` |
| cross-cutting architecture decision | ADR process |
| product decision hidden in architecture | product arbitration (PD-*) |
