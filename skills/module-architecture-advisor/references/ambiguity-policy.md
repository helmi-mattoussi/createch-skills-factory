# Ambiguity Policy

This document defines how the skill must behave when architecture decisions cannot be made without additional information.

---

# Core rule

When architecture ambiguity exists:
1. do not invent entity fields, services, or behaviors not grounded in validated `.feature`
2. prefer the simplest implementable architecture when safe
3. trace ambiguity when it materially affects builders
4. require an ADR when the pending decision is cross-cutting, security-sensitive, or difficult to reverse

---

# Architecture ambiguity levels

## Level 1 — Low-risk

Examples:
- minor service naming choice
- obvious standard technical field (created_at, updated_at)
- common standard pattern clearly fits

Expected behavior:
- resolve directly
- note as technical necessity or assumption
- no escalation

---

## Level 2 — Medium-risk

Examples:
- a field is implied by a behavior but not explicitly in any `.feature`
- API route naming is ambiguous between two options
- service decomposition has two reasonable options
- a state is implied but not yet specced

Expected behavior:
- choose the simpler, more conventional option
- note as assumption
- mark as Needs validation if likely to be contested
- add to ADR list if a formal decision is warranted

---

## Level 3 — High-risk

Examples:
- security-sensitive permission enforcement strategy
- caching strategy with significant behavioral implications
- cross-module event vs synchronous call
- row-level security enforcement approach
- entity field that affects another module's data model
- refactoring that could inadvertently change behavior

Expected behavior:
- do not make the decision unilaterally
- design the most conservative or reversible option
- mark as required ADR
- present options when known

---

# Conservative module architecture rule

Conservative design means:
- prefer fewer, well-focused services over many micro-services
- prefer synchronous over event-driven when event-driven is not required
- prefer standard patterns (Repository, Service, DTO) over complex patterns when complexity is not justified
- include only fields grounded in validated behaviors
- keep the state machine minimal — only confirmed states and transitions

---

# When the skill may resolve ambiguity alone

All of the following must be true:
- the decision is low-risk
- it follows established practice for the technology stack
- the choice does not affect the behavioral contract
- it can be stated as a technical assumption
- it is easily reversible

---

# When ADR is required

Mark as required ADR when the pending decision affects:
- how another module interacts with this module
- security or permission enforcement
- performance-critical operations
- caching at module level
- async vs synchronous processing
- sensitive data handling

---

# ADR need format

```markdown
ADR needed:
- Topic: <what must be decided>
- Scope: this module / cross-cutting
- Why it matters: <implementation consequence>
- Options: A / B
- Conservative recommendation: <simplest or most reversible option>
```

---

# Ambiguity trace format

When a trace is needed for a builder-affecting decision:

```markdown
Architecture Ambiguity
- <what is unclear>

Observed sources
- <.feature or PD-* reference>

Conservative architecture choice
- <what was designed conservatively>

Risk for builders
- <why this matters for implementation>

Needs validation / Required ADR
- <what must be decided before this is final>
```
