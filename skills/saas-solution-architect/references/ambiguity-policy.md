# Ambiguity Policy

This document defines how the skill must behave when an architecture decision cannot be made without additional information.

---

# Core rule

When architecture ambiguity exists:
1. do not invent cross-cutting or irreversible decisions
2. prefer the simplest and most reversible architecture when safe
3. trace ambiguity when it materially affects module design
4. require ADR when the decision is genuinely cross-cutting, sensitive, or difficult to reverse

---

# Architecture ambiguity levels

## Level 1 — Low-risk ambiguity

A minor architecture uncertainty that does not affect module boundaries, ownership, or delivery phases.

Examples:
- exact naming of a module (workspace vs organization)
- minor dependency sequence

Expected behavior:
- resolve directly using the most domain-aligned option
- note the choice as an assumption
- no escalation required

---

## Level 2 — Medium-risk ambiguity

An architecture uncertainty that affects module responsibility or delivery boundary but can be handled conservatively.

Examples:
- a capability could belong to two adjacent modules
- the MVP delivery phase for a borderline feature is unclear
- a shared module is needed but its ownership is not obvious

Expected behavior:
- choose the simplest, most grounded assignment
- make the boundary explicit
- make the assumption explicit
- note as Needs validation if the choice is likely to be contested
- add to ADR list if a formal decision is warranted

---

## Level 3 — High-risk ambiguity

An architecture uncertainty that affects cross-cutting structure, sensitive decisions, or difficult-to-reverse choices.

Examples:
- auth strategy not yet decided
- multi-tenancy isolation model not yet decided (row-level vs schema vs database)
- event-driven vs synchronous at system level
- external service selection with vendor lock-in implications
- data residency or sovereignty requirements
- module structure depends on unresolved product scope

Expected behavior:
- do not make the decision unilaterally
- design the most technology-agnostic or reversible architecture possible
- identify it explicitly as a required ADR
- present the main options when known
- recommend the conservative or most reversible option when obvious

---

# Conservative architecture rule

When a conservative architecture choice is allowed:

- prefer domain-oriented modules over technical-layer modules
- prefer fewer, well-bounded modules over many micro-modules
- prefer synchronous over event-driven when event-driven is not required
- prefer monolith-compatible architecture over microservices unless explicitly required
- prefer standard well-established patterns over novel ones
- defer cross-cutting decisions to ADR rather than embedding them silently

---

# When architecture may resolve ambiguity alone

The skill may resolve ambiguity alone when all of the following are true:
- the architecture choice is low-risk and follows standard practice
- it does not affect module ownership or cross-module boundaries meaningfully
- it does not involve sensitive or compliance-relevant decisions
- it can be stated explicitly as an assumption
- it is easily reversible if the direction turns out to be wrong

---

# When a required ADR must be created

Mark a required ADR when the pending decision affects:
- the overall system communication style (sync vs async, event-driven vs request-driven)
- the authentication and authorization layer
- the data isolation or tenancy model
- the external service dependency (vendor, SaaS integration)
- the infrastructure deployment model (serverless, containerized, hybrid)
- the API contract style (REST, GraphQL, gRPC)
- the caching or state management strategy at system level
- any decision that is cross-cutting and difficult to reverse

---

# ADR need format

When a required ADR is identified:

```markdown
ADR needed:
- Topic: <what must be decided>
- Why it matters: <consequence of leaving undecided on the architecture>
- Options: A / B (if known)
- Conservative recommendation: <if any>
```

---

# Architecture ambiguity trace format

When a trace is needed:

```markdown
Architecture Ambiguity
- <short statement of what is unclear>

Observed sources
- <source 1>
- <source 2>

Conservative architecture choice
- <what was designed conservatively>

Risk for module-architecture-advisor
- <why this matters downstream>

Needs validation / Required ADR
- <what must be decided>
```
