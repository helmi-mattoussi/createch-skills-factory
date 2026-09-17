# Decision Matrix

This document provides a compact decision framework for recurring situations encountered while designing or revising UX flows.

Use this matrix together with:
- `ambiguity-policy.md`
- `revision-rules.md`
- `red-flags.md`
- `source-priority.md`

---

# Core rule

When a situation matches one of the cases below, apply the recommended behavior directly.

If multiple cases apply:
1. protect source-of-truth integrity first
2. protect permissions, safety, and scope second
3. preserve validated UX decisions third
4. optimize output clarity last

---

# Matrix

| Situation | Risk level | Expected behavior | Output pattern |
|---|---|---|---|
| Flow is clearly scoped and actors are explicit | Low | Design normally | UX Design Note |
| Minor UX convention gap exists | Low | Apply common safe convention | UX Design Note |
| Label or wording ambiguity only | Low | Use project vocabulary | UX Design Note |
| Screen needs an obvious secondary action implied by documented behavior | Low to medium | Add it conservatively | UX Design Note |
| Scope boundary is likely to drift during UX design | Medium | Add UX out-of-scope section | UX Design Note |
| Error or failure path is missing but safe handling is obvious | Medium | Add conservative failure path | UX Design Note + assumption |
| One UX detail is unclear but conservative interpretation is safe | Medium | Design conservatively and note assumption | UX Design Note + assumption |
| Actor or permission for a visible action is unclear | High | Design for the most restrictive access | UX Design Note + Needs validation |
| Two plausible UX directions exist | High | Do not choose silently | partial UX Design Note + Needs validation |
| Destructive action lacks product validation | High | Design conservative confirmation step | UX Design Note + Needs validation |
| Visibility of sensitive data depends on unresolved permission | High | Show least data by default | UX Design Note + Needs validation |
| UX flow implies scope expansion not in framing | High | Keep expansion out of scope | UX Design Note + UX out-of-scope |
| UX choice depends on unresolved architecture decision | High | Design conservative fallback UX | UX Design Note partial + architecture dependency note |
| Navigation implies a product capability not yet validated | High | Keep the capability out of scope | UX Design Note + Needs validation |
| Revision would add new screens or flows | High | Do not absorb as cleanup | UX scope-change note + validation required |
| Revision contradicts a validated product decision | High | Preserve the validated choice | UX Design Note unchanged + conflict surfaced |
| Framing not yet complete or gate not passed | High | Design is premature | explain gap + redirect to brief-to-product-docs |
| Request is for .feature writing, not UX design | High | Do not produce .feature | redirect to sdd-spec-writer |
| Only a UX subset is stable | Medium to high | Design only the stable subset | partial UX Design Note + Needs validation |

---

# Fast decision rules

## Rule 1 — If the issue is only UX convention
Apply the safe, common convention and note the assumption.

Typical outputs:
- standard layout applied
- common error display pattern used
- common confirmation pattern used

No escalation required.

---

## Rule 2 — If a UX detail is missing but obviously safe
Complete conservatively and note assumption.

Typical outputs:
- missing failure path added
- missing out-of-scope boundary added
- implied secondary action added with note

---

## Rule 3 — If the UX choice changes product meaning
Do not treat as editorial cleanup.

Typical outputs:
- Needs validation
- ambiguity trace when specification impact is material

---

## Rule 4 — If actor or permission is unclear
Default to the most restrictive visibility.

Never:
- show sensitive data to all actors silently
- assume broad access for a visible action
- infer cross-actor visibility without explicit support

For destructive actions, validation is mandatory.

---

## Rule 5 — If source conflict exists
Apply source priority before designing.

Never:
- design a UX that contradicts a validated PD-*
- overwrite a validated UX decision based on Jira wording alone
- use existing code UX as truth when framing disagrees

---

## Rule 6 — If scope expansion is implied
Keep unsupported features out of scope.

Typical examples:
- list page does not imply search / filter / bulk actions unless in scope
- create form does not imply bulk import unless in scope
- archive action does not imply restore unless in scope

Treat expansion as explicit UX contract change.

---

## Rule 7 — If a stable UX subset exists
Deliver the stable subset instead of blocking completely.

Good pattern:
- design what is grounded
- isolate what remains unresolved
- keep unsupported behavior out of UX scope
- mark validation where required

---

# Output chooser

## Output: UX Design Note only
Use when:
- flow is well-scoped
- actors and permissions are clear
- no meaningful unresolved UX decision remains

## Output: UX Design Note + Needs validation
Use when:
- one or two UX decisions remain open
- the design is mostly stable and useful
- assumptions were made that could affect the spec

## Output: UX Design Note + ambiguity trace
Use when:
- unresolved point materially affects sdd-spec-writer's ability to specify
- source conflict exists
- permission or data visibility issue remains

## Output: partial UX Design Note + validation required
Use when:
- only part of the UX flow is stable
- the rest depends on unresolved product or architecture decisions
- safe progress is still possible on the stable subset

## Output: no UX design, explain why
Use when:
- product framing is incomplete or the gate has not passed
- the request is actually for .feature writing or architecture
- no stable UX subset can be designed without invention

---

# Escalation chooser

| If the issue is mainly about... | Escalate conceptually toward... |
|---|---|
| fuzzy product need | upstream product framing (`brief-to-product-docs`) |
| unresolved product scope or actor | upstream product decision (PD-*) |
| unresolved architecture constraint on UX | `module-architecture-advisor` |
| sensitive permission or visibility | explicit product validation |
| scope expansion | upstream product/spec decision |
| .feature writing | `sdd-spec-writer` |

Do not offload casually. Only escalate when the UX designer would otherwise have to invent.

---

# Anti-pattern guardrail

Never choose a cleaner-looking UX design over a more honest one.

Examples of wrong behavior:
- designing complete-looking flows that hide unresolved product decisions
- adding screens for unsupported features to make the flow feel complete
- designing for the broadest actor access when permission is unclear
- presenting a scope change as a small UX addition
- treating Jira wording as sufficient reason to override validated framing
