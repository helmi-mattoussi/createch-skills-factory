# Revision Rules

This document defines how the skill must behave when evolving an existing Solution Architecture Map.

---

# Core rule

In evolution mode:

1. preserve validated architecture decisions by default
2. update only what is grounded in new validated product framing or ADR
3. surface all meaningful architecture changes explicitly
4. do not absorb scope expansion as natural architectural evolution
5. do not silently change module ownership or remove boundaries

---

# What evolution is allowed to do

Evolution may:

- add new modules when new capabilities are grounded in validated framing
- update a module's responsibility when new framing changes its scope
- update dependency map when a new module is added
- refine MVP delivery boundary based on ADR decisions made since the original map
- add new required ADR needs discovered during evolution
- add or update "Notes for module-architecture-advisor" as understanding deepens
- improve wording without changing architecture meaning

---

# What evolution must not do

Evolution must not:

- remove an existing module without explicit justification from a higher-priority source
- change module ownership silently
- add capabilities not grounded in any validated framing
- split a module without a clear boundary justification
- merge modules without surfacing the change and its consequences
- resolve pending ADR decisions unilaterally
- inflate the MVP boundary based on a Jira request alone
- remove a "Does not own" boundary to simplify the look of the map

---

# Revision type classification

## Type 1 — Editorial improvement

Low-risk.

Examples:
- improve wording of a module responsibility
- add a missing "Does not own" item that was implied but not stated
- improve delivery order explanation

Expected behavior:
- revise directly
- no escalation needed

---

## Type 2 — Capability addition from validated framing

Medium-risk.

Examples:
- add a new module because a new Product Framing Dossier was added
- update a module's responsibility because the framing was updated
- extend the dependency map because a new external dependency was confirmed

Expected behavior:
- add the new content from the validated source
- note the meaningful changes explicitly
- update the ADR list if new decisions are now required

---

## Type 3 — Architecture correction from ADR

Higher-risk.

Examples:
- a newly decided ADR changes the data isolation approach
- a newly decided ADR changes the notification trigger pattern
- an architecture decision made previously must be updated

Expected behavior:
- apply the change from the ADR
- surface the change explicitly with the ADR reference
- update affected module notes for module-architecture-advisor

---

## Type 4 — Structural change (merge, split, reorientation)

High-risk.

Examples:
- splitting a module into two
- merging two modules into one
- changing the ownership of a capability from one module to another

Expected behavior:
- surface explicitly as a structural architecture change
- explain the rationale clearly
- surface consequences (which ADR may need updating, which modules are affected)
- require validation before applying if the change is cross-module

---

# Preservation rule

When in doubt, preserve:
- existing validated module responsibilities
- existing "Does not own" boundaries
- existing ADR-grounded decisions
- existing MVP delivery boundary

Do not remove boundaries or decisions because they feel obvious or outdated.

---

# Meaningful change format

When an evolution changes module responsibility, boundaries, dependencies, or MVP phase, state it explicitly.

Recommended note:
```markdown
Meaningful changes in this evolution
- <change 1> (source: <framing or ADR reference>)
- <change 2> (source: <framing or ADR reference>)
```
