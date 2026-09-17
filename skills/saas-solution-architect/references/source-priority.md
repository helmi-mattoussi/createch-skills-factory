# Source Priority

## System-level hierarchy (4 levels — applies to all skills)

Use this order when sources conflict:
1. applicable and most recent `PD-*` / `ADR-*`
2. validated `.feature`
3. Jira ticket
4. existing code

---

## Architecture-specific reading rules

### Level 1 — PD-* and ADR-*

These are the highest-priority sources for architecture decisions.

PD-* constrains architecture when it:
- defines product scope boundaries that affect module size
- defines data ownership rules
- defines multi-tenancy or workspace isolation requirements
- defines external integration requirements

ADR-* constrains architecture when it:
- defines the technology stack already chosen
- defines an existing integration pattern
- defines a data isolation strategy already adopted
- defines an event-driven or synchronous communication pattern already in use

Do not override existing ADR-* without surfacing the conflict and requiring a new ADR.

### Level 2 — Validated .feature

If validated `.feature` files exist, read them to:
- understand the scope of implemented behaviors per module
- ensure that the module map respects the behavioral boundaries already established
- avoid creating a module map that contradicts what has already been specified

Do not redesign the module structure in ways that would invalidate validated `.feature` files without surfacing the conflict.

### Level 3 — Product Framing Dossier

The Product Framing Dossier is the primary architecture input.

It provides:
- the product scope (what capabilities must exist)
- the actors (who uses the system — affects multi-tenancy and permission surface)
- the known business rules (which may affect module responsibility)
- the out-of-scope (which capabilities are explicitly excluded)

### Level 4 — Jira ticket

Jira is additional context only.

Jira may provide:
- delivery intent
- linked features
- team expectations

Jira must not override higher-priority sources.

### Level 5 — Existing code

Read existing code only as a structural signal.

It may reveal:
- what has already been built
- what module structure exists in practice
- what technical debt is present

Do not treat existing code as the architecture truth if it contradicts validated framing or ADR-*.

---

## Conflict handling

When sources conflict:
1. apply source priority above
2. surface the conflict in the output (do not merge silently)
3. follow the higher-priority source
4. mark as Needs validation if the conflict has significant architectural consequence

When an architecture choice depends on an unresolved product or technology decision:
- design the most conservative or reversible architecture
- mark the pending decision as a required ADR
- do not make final irreversible choices without validation
