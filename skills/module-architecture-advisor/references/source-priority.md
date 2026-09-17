# Source Priority

## System-level hierarchy (applies to all skills)

1. applicable and most recent `PD-*` / `ADR-*`
2. validated `.feature`
3. Jira ticket
4. existing code

---

## Module-architecture-specific reading rules

### Level 1 — ADR-*

For module architecture, ADR-* are the most important technical source.

They define:
- which patterns must be used (e.g., command/handler, event-driven)
- which technology choices apply (e.g., Doctrine ORM, API Platform config style)
- which integration patterns are required (e.g., how cross-module calls work)
- which security and data isolation approaches are in effect

Do not design a module architecture that contradicts an existing ADR.
If a new module-specific decision contradicts an existing ADR, surface the conflict and require a new ADR.

### Level 1 — PD-*

PD-* constrain entity model and permissions when they:
- define data ownership rules
- define visibility rules (who can see what data)
- define workspace-scoping rules
- define lifecycle constraints (e.g., archived entities cannot be deleted)

### Level 2 — Validated .feature

Validated `.feature` files are the **primary behavioral source** for module architecture.

Every entity field, API operation, and state transition should be traceable to at least one `.feature` scenario.

If a design decision cannot be grounded in a `.feature`, it must be labeled:
- as a confirmed technical necessity (e.g., created_at, soft delete flag)
- or as an assumption
- or as a Needs validation item

Do not add entity fields, API operations, or services that have no `.feature` grounding.

### Level 3 — Jira ticket

Read Jira for context only.
Do not use Jira wording to introduce architecture decisions not in the `.feature` or PD-*.

### Level 4 — Existing code

In refactor mode, existing code is the working baseline.

Treat existing code as:
- a description of the current implementation state
- a source of what behaviors already work
- not as the architectural authority if it contradicts validated `.feature` or ADR

When existing code and validated `.feature` conflict:
- the `.feature` wins
- document the gap that the refactoring must close

---

## Conflict handling

When sources conflict:
1. apply source priority
2. surface the conflict in the output
3. follow the higher-priority source
4. mark as Needs validation if the conflict has significant architecture consequence
