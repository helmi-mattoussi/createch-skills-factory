# Revision Rules

This document defines how the skill must behave in refactor mode.

---

# Core rule

In refactor mode:

1. never change the validated behavioral contract — only the internal structure
2. preserve validated entity fields and relationships if they are grounded in .feature
3. surface meaningful structural changes explicitly
4. do not introduce new architecture patterns without justification
5. do not reduce the state machine scope below what is in validated .feature

---

# What refactoring is allowed to do

Refactoring may:

- reorganize services to achieve better single-responsibility separation
- rename services when naming is misleading
- split an overly broad service into focused services
- consolidate artificial service splits that have no real distinction
- introduce or remove a pattern if clearly justified (e.g., introducing Repository pattern to decouple data access)
- clarify and formalize the API contract if it was implicit
- formalize the state machine if it was informal
- correct entity field naming to match domain vocabulary
- add missing entity fields that are grounded in validated `.feature` but missing in the implementation
- add or update ADR needs discovered during the refactor analysis

---

# What refactoring must not do

Refactoring must not:

- remove entity fields that are in use by validated `.feature` behaviors
- change state machine states or transitions that are in validated `.feature` (those require `.feature` update first)
- add API operations not backed by validated `.feature`
- remove API operations that are in validated `.feature`
- change the module boundary (that requires `saas-solution-architect`)
- add services or patterns for aesthetic reasons without behavioral justification
- change entity validation rules that are in validated `.feature`

---

# Behavioral contract preservation rule

If a refactoring change would require modifying a validated `.feature` to stay accurate:
- that change is not a refactoring
- it is a behavioral change
- it must go through `sdd-spec-writer` first

---

# Refactor type classification

## Type 1 — Service restructuring

Low-risk.

Examples:
- splitting an omnibus service into two focused ones
- renaming a poorly named service
- moving a concern from one service to the right one

Expected behavior:
- restructure and justify
- note the change

---

## Type 2 — Pattern introduction or removal

Medium-risk.

Examples:
- introducing Repository pattern where direct entity access was used
- removing a pattern that is not needed at the current scale

Expected behavior:
- introduce or remove with clear justification
- ensure behavioral contract is not affected

---

## Type 3 — Entity model formalization

Medium-risk.

Examples:
- adding missing entity fields grounded in validated .feature
- formalizing relationships that were implicit
- normalizing field names to domain vocabulary

Expected behavior:
- apply only field changes grounded in validated source
- note changes and their grounding

---

## Type 4 — Behavioral boundary change

High-risk. This is NOT a standard refactoring.

Examples:
- adding behaviors not in any validated .feature
- removing behaviors in validated .feature

Expected behavior:
- do not absorb as refactoring
- surface explicitly
- require `.feature` update before architectural change in this area

---

# Meaningful change format

State meaningful structural changes explicitly:

```markdown
Meaningful structural changes in this refactoring
- <change 1> — reason: <why it improves the structure>
- <change 2> — reason: <why it improves the structure>

Changes not included (require .feature update first)
- <behavioral element that cannot be changed in this refactoring>
```
