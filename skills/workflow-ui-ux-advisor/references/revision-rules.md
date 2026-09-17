# Revision Rules

This document defines how the skill must behave when revising an existing UX Design Note.

Revision is a high-risk activity because the skill can accidentally:
- rewrite validated UX decisions
- widen the UX scope
- normalize drift from implementation or Jira
- remove important UX constraints while "improving" the design
- introduce unvalidated product changes through UX changes

The objective of revision is not to redesign for elegance.
The objective is to update the UX Design Note based on new validated information while preserving what was already correct.

---

# Core rule

In revise mode:

1. preserve validated UX decisions by default
2. update only what is grounded in new validated information
3. do not widen UX scope unless a higher-priority source explicitly requires it
4. clearly surface meaningful UX changes
5. never disguise a UX scope change as editorial cleanup

---

# What revision is allowed to do

Revision may:

- incorporate new UX requirements from an updated Product Framing Dossier
- update screen structure based on a new or revised PD-*
- add UX edge cases that are clearly implied by documented new behavior
- clarify wording without changing meaning
- add UX out-of-scope boundaries to prevent drift
- re-order sections for readability
- add missing Needs validation items discovered during review
- align with a new ADR-* that changes a UX constraint

These improvements are allowed only if they do not silently change the validated UX direction.

---

# What revision must not do

Revision must not:

- add screens or flows not supported by the updated framing
- widen actor visibility or permissions
- change navigation flow without a grounded source
- remove a UX constraint that was grounded in a PD-* or ADR-* unless superseded
- assume that Jira wording is sufficient reason to change a validated UX decision
- introduce new feature UX (search, filter, bulk, export) as minor additions
- present a UX scope change as wording improvement
- convert a Needs validation item into a resolved decision without a documented source

---

# Revision type classification

## Type 1 — Editorial cleanup

Low-risk revision.

Examples:
- clarify actor label wording
- normalize state names to project vocabulary
- improve step descriptions in the user journey
- reorder sections for clarity

Expected behavior:
- revise directly
- no escalation needed

---

## Type 2 — UX completion from grounded source

Medium-risk revision.

Examples:
- add a missing failure path implied by a documented business rule
- add a UX edge case clearly required by a new PD-*
- add an out-of-scope boundary to prevent implementation drift

Expected behavior:
- revise carefully
- note the addition as a meaningful change if it affects the behavioral contract
- add assumption note when useful

---

## Type 3 — UX correction from higher-priority source

Higher-risk revision.

Examples:
- a new PD-* changes who sees a screen
- a new ADR-* changes a navigation behavior (e.g., async replaces synchronous interaction)
- an updated framing restricts the scope and a screen must be removed

Expected behavior:
- apply the change from the higher-priority source
- surface the change explicitly
- do not present it as editorial cleanup
- mark validation if the business impact of the UX change is meaningful

---

## Type 4 — UX scope-changing revision

Not ordinary revision.

Examples:
- adding new screens not in the original framing
- extending a form with new fields not validated
- changing which actor can trigger an action
- adding navigation paths not previously designed

Expected behavior:
- do not silently apply
- treat as explicit UX contract change
- mark Needs validation
- surface the scope change clearly
- redirect to updated product framing or product decision if needed

---

# Preservation rule

When in doubt, preserve:
- existing validated UX decisions
- existing explicit UX constraints from PD-* and ADR-*
- existing out-of-scope boundaries
- existing actor restrictions

Do not remove a UX decision unless a higher-priority source clearly invalidates it.

---

# Meaningful change rule

A UX change must be surfaced explicitly if it affects:
- screen structure (which screens exist or what is on them)
- navigation flow (how screens connect)
- UI state model (which states exist or what they mean)
- actor visibility (who sees what)
- form fields or validation rules
- user journey (nominal or failure path)
- important UX edge cases

Do not hide these changes inside polished rewritten prose.

Recommended short note:
```markdown
Meaningful UX changes
- <change 1 and source>
- <change 2 and source>
```

---

# Revision anti-patterns

Do not:
- rewrite the entire UX Design Note because the original style is weak
- add feature completeness (search, filters, export) without source support
- change actor permissions silently while improving wording
- present new screens as "natural additions"
- use existing implementation as justification to change the UX Design Note
- remove Needs validation items because they feel resolved without a documented decision
- convert an open UX decision into a confident design because time is short
