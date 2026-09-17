# Decision Matrix

This document provides a decision framework for recurring situations during solution architecture design or evolution.

---

# Core rule

When a situation matches a case below, apply the recommended behavior.

Priority order:
1. protect existing validated ADR-* and PD-*
2. protect scope from inflation
3. design the simplest reversible architecture
4. surface decisions rather than making them unilaterally when risk is high

---

# Matrix

| Situation | Risk level | Expected behavior | Output pattern |
|---|---|---|---|
| Product scope is clearly bounded with explicit modules | Low | Map normally | Solution Architecture Map |
| A standard architectural pattern clearly fits | Low | Apply it and note the assumption | Solution Architecture Map |
| Minor module naming ambiguity | Low | Use domain vocabulary and normalized name | Solution Architecture Map |
| Module responsibility is clear but boundary with neighbor is fuzzy | Medium | Clarify boundary explicitly with "does not own" | Solution Architecture Map with explicit boundaries |
| A useful capability is implied but not in framing | Medium | Keep it out of scope, note it as V2+ | Solution Architecture Map + V2+ note |
| Module needs a shared capability (e.g. notifications) | Medium | Create a shared module, define who depends on it | Solution Architecture Map + shared module note |
| MVP boundary is ambiguous | Medium | Be conservative: exclude what is not essential | Solution Architecture Map + explicit MVP justification |
| Two modules could own the same data | High | Assign to one module, make boundary explicit | Solution Architecture Map + boundary decision surfaced |
| Technology stack is uncertain | High | Mark as ADR need, design technology-agnostic modules | Solution Architecture Map + ADR list |
| Auth strategy is not yet decided | High | Mark as ADR need, do not hardcode auth approach | ADR need |
| Multi-tenancy model is not yet decided | High | Mark as ADR need, design modules without locking model | ADR need |
| Data isolation strategy is not yet decided | High | Mark as ADR need, propose conservative options | ADR need |
| Circular dependency detected | High | Surface it, propose resolution options | Needs validation |
| External service implies vendor lock-in | High | Surface it, mark as ADR need | ADR need |
| Evolution adds capabilities not in any validated framing | High | Design only grounded capabilities | partial map + upstream framing required |
| Evolution conflicts with existing ADR-* | High | Preserve ADR, surface conflict, require new ADR | conflict surfaced + ADR need |
| Architecture would require a difficult-to-reverse decision | High | Do not make it unilaterally | ADR need + options |
| Only a partial architecture is groundable | Medium to high | Design the grounded subset only | partial Solution Architecture Map + needs validation |

---

# Fast decision rules

## Rule 1 — Keep modules bounded by domain, not by feature
Good modules are named after domains (invoicing, workspace, notifications, identity).
Bad modules are named after features (archiveInvoice, inviteUser).

## Rule 2 — When a capability could belong to two modules, assign it to one and be explicit
The boundary must be explicit.
Shared ambiguity between modules always becomes a build problem.

## Rule 3 — When the stack is uncertain, design technology-agnostic
Technology-agnostic module maps remain useful regardless of stack choice.
This is the safest conservative posture when ADR is pending.

## Rule 4 — When uncertain about MVP boundary, be conservative
A smaller MVP is almost always better.
An overloaded MVP is a delivery risk and a product clarity risk.

## Rule 5 — Cross-cutting sensitive decisions are always ADR candidates
Never make the following decisions unilaterally:
- auth strategy
- data isolation / multi-tenancy
- external service selection that creates dependency
- event-driven vs synchronous at system level

---

# Output chooser

## Output: Complete Solution Architecture Map
Use when:
- product scope is clear and bounded
- technology stack is defined
- no blocking ADR is pending
- all modules can be mapped cleanly

## Output: Solution Architecture Map + ADR list
Use when:
- most of the architecture is groundable
- some cross-cutting decisions are still pending
- the architecture can be designed without locking those decisions

## Output: Solution Architecture Map + Needs validation
Use when:
- one or two module boundaries are genuinely ambiguous
- the ambiguity has product or organizational implications
- a partial but useful map can still be delivered

## Output: Partial Solution Architecture Map + upstream framing required
Use when:
- part of the product scope is not yet grounded in validated framing
- a useful partial map exists for the grounded part
- the rest requires framing before architecture can follow

## Output: No architecture — explain why
Use when:
- product framing is incomplete
- no stable module subset can be mapped without invention
- the request is actually for module internals or .feature writing

---

# Escalation chooser

| If the issue is mainly about... | Escalate conceptually toward... |
|---|---|
| unframed product scope | upstream product framing (`brief-to-product-docs`) |
| unresolved product capability decision | product decision (PD-*) |
| sensitive cross-cutting technical decision | architecture decision (ADR-*) |
| module internals | `module-architecture-advisor` |
| behavioral specification | `sdd-spec-writer` |
| security or compliance implications | `security-compliance-guardian` |
| performance or scalability implications | `performance-scalability-advisor` |
