# Source Priority

## System-level hierarchy (4 levels — applies to all skills)

Use this order when sources conflict:
1. applicable and most recent `PD-*` / `ADR-*`
2. validated `.feature`
3. Jira ticket
4. existing code

This is the standard project-wide hierarchy defined in the master governance reference.

---

## UX-specific reading rules

### Level 1 — PD-* and ADR-*

These are the highest-priority sources.

For UX design:
- PD-* defines product rules that constrain what is visible, who sees it, what is editable, and what triggers are valid
- ADR-* defines technical constraints that affect UX behavior (e.g., async behavior, pagination, file size limits, real-time vs batch)

These override the Product Framing Dossier when they conflict.

### Level 2 — Validated .feature

If a validated `.feature` already exists for an adjacent or related behavior, read it to maintain consistency.

Do not contradict a validated `.feature` without detecting and surfacing the conflict.

### Level 3 — Product Framing Dossier

The primary UX input source.

The framing dossier provides:
- business objective (why the flow exists)
- actors (who uses the flow)
- scope (what must be included)
- out-of-scope (what must not be included)
- known business rules (which constrain UX behavior)
- assumptions (which must remain labeled as such)
- open questions and arbitration points (which block some UX decisions)

### Level 4 — Jira ticket

Read Jira only after the above.

Jira may provide:
- additional context
- client wording
- linked items

Jira must not override the framing dossier or PD-*.

### Level 5 — Existing code

Read existing code only as a signal.

Existing code may reveal:
- what is currently implemented
- possible inconsistencies with framing

Do not treat existing code as the truth authority for UX design.

---

## Conflict handling

When two sources conflict:

1. apply source priority above
2. do not merge conflicting intentions silently
3. surface the conflict in the output
4. require validation if the conflict affects scope, actors, or permissions

When a UX choice depends on an unresolved product question:
- do not invent the product answer
- design the UX for the most conservative plausible interpretation
- mark the decision as Needs validation
