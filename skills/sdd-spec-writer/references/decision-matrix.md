# Decision Matrix

This document provides a compact decision framework for recurring situations encountered while creating or revising `.feature` specifications.

Its purpose is to make the skill's behavior:
- predictable
- consistent
- conservative where needed
- explicit when escalation is required

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
3. preserve validated intent third
4. optimize output clarity last

---

# Matrix

| Situation | Risk level | Expected behavior | Output pattern |
|---|---|---|---|
| Need is clearly scoped and behavior is explicit | Low | Draft normally | `.feature` |
| Need is mostly clear but one minor wording gap exists | Low | Resolve directly using project vocabulary | `.feature` |
| Existing `.feature` is weak in wording only | Low | Revise editorially | revised `.feature` |
| Existing `.feature` mixes multiple behaviors in one scenario | Low to medium | Split scenarios without changing meaning | revised `.feature` |
| Obvious business rule is already documented in higher-priority source but missing from `.feature` | Medium | Add it explicitly | revised `.feature` |
| Obvious error case is required by documented rule | Medium | Add conservative failure scenario | `.feature` or revised `.feature` |
| Edge case is implied by documented behavior and affects implementation | Medium | Add explicit scenario | `.feature` or revised `.feature` |
| Scope boundary is likely to drift during implementation | Medium | Add `Out of scope` boundary | `.feature` |
| Behavior is partially unclear but safest interpretation is obvious and low-risk | Medium | Draft conservatively and note assumption if useful | `.feature` + optional companion note |
| Framing is validated but UX / interaction design is not yet stable for UX-dependent behavior | Medium to high | Draft only the UX-independent behavioral subset | partial `.feature` + `Needs validation` for UX-dependent parts |
| Business behavior has two plausible interpretations | High | Do not choose silently | `.feature` partial or conservative + `Needs validation` |
| Permission for meaningful action is unclear | High | Do not infer broad access | conservative `.feature` + `Needs validation` |
| Sensitive action permission is unclear | High | Do not resolve silently | ambiguity trace + `Needs validation` |
| Jira conflicts with validated `.feature` | High | Preserve validated `.feature` unless higher source supersedes it | revised `.feature` + conflict surfaced |
| Code conflicts with PD/ADR or validated `.feature` | High | Follow validated source, not code | `.feature` or revised `.feature` + drift surfaced |
| Two sources of same apparent authority imply different outcomes | High | Do not merge silently | ambiguity trace + `Needs validation` |
| Request implies new supported variant not yet validated | High | Treat as scope change, not cleanup | `Needs validation` + explicit scope note |
| Revision would broaden scope | High | Do not apply as normal revision | scope-change note + validation required |
| Revision would change acceptance behavior | High | Surface as meaningful change | revised `.feature` + meaningful changes note |
| Revision would remove existing explicit constraint | High | Preserve it unless superseded | revised `.feature` or block change |
| Workflow state transition is unclear | High | Preserve only documented transitions | conservative `.feature` + validation if material |
| Restore/reopen/retry/resubmit behavior is implied but not documented | High | Keep out of scope unless validated | `.feature` + `Out of scope` or `Needs validation` |
| UX flow is not stable enough to define trigger or sequence | High | Do not lock behavior as final | partial contract + validation required |
| Requested behavior depends on unresolved architecture responsibility | High | Keep spec behavioral only and surface dependency | `.feature` partial + architecture dependency note |
| Sensitive data visibility/retention behavior is unclear | High | Do not infer permissive behavior | ambiguity trace + `Needs validation` |
| Need is still discovery, not specification | High | Do not pretend it is spec-ready | explain missing framing / do not draft full contract |
| Only a stable subset is spec-ready | Medium to high | Draft only the grounded subset | partial `.feature` + `Out of scope` + `Needs validation` |

---

# Fast decision rules

## Rule 1 - If the issue is only editorial
Revise directly.

Typical outputs:
- improved wording
- clearer scenario names
- normalized vocabulary
- separated scenarios

No escalation required unless another issue appears.

---

## Rule 2 - If the issue is completeness but grounded
Complete conservatively.

Typical outputs:
- missing rule made explicit
- missing failure case added
- missing scope boundary added

Use a short companion note only if the addition could be misread as a product decision.

---

## Rule 3 - If the issue changes behavior meaning
Do not treat it as cleanup.

Typical outputs:
- `Needs validation`
- meaningful changes note
- ambiguity trace if conflict or uncertainty remains

---

## Rule 4 - If permissions are unclear
Default to the narrowest safe interpretation.

Never:
- broaden access silently
- assume admin rights
- infer cross-scope visibility

For sensitive actions, validation is mandatory.

---

## Rule 5 - If source conflict exists
Apply source priority before drafting.

Never:
- average conflicting meanings
- optimize for current code convenience
- overwrite validated intent from Jira wording alone

---

## Rule 6 - If scope expansion is implied
Keep unsupported extensions out of scope.

Typical examples:
- single action does not imply batch
- archive does not imply restore
- export does not imply scheduled export
- read does not imply edit

Treat expansion as explicit contract change.

---

## Rule 7 - If workflow lifecycle is unclear
Preserve only documented transitions.

Never assume:
- reopen
- restore
- retry
- resubmit
- rollback

unless explicitly supported.

---

## Rule 8 - If a safe subset exists
Deliver the safe subset instead of blocking completely.

Good pattern:
- draft what is grounded
- isolate what remains unresolved
- keep unsupported behavior out of scope
- mark validation where required

---

# Output chooser

Use this quick mapping to choose the right output form.

## Output: `.feature` only
Use when:
- request is well-scoped
- ambiguity is low
- no meaningful unresolved issue remains

## Output: `.feature` + companion note
Use when:
- conservative assumption is needed
- one or two unresolved points remain
- the spec is still useful and mostly stable

Companion note may include:
- `Assumptions`
- `Open questions`
- `Needs validation`
- `Out of scope`

## Output: `.feature` + ambiguity trace
Use when:
- unresolved point materially affects contract meaning
- source conflict exists
- permission, scope, state, or sensitive-data issue remains

## Output: partial `.feature` + validation required
Use when:
- only part of the behavior is stable
- full contract would require invention
- safe progress is still possible

## Output: no full spec, explain missing framing
Use when:
- request is still discovery
- workflow is not defined
- business choice is not decided
- architecture dependency prevents reliable contract drafting

---

# Meaningful change rule in revise mode

A change must be surfaced explicitly if it affects:
- behavior outcome
- supported actor
- permission boundary
- accepted input or state
- rejection logic
- scope boundary
- state transition
- important edge case

Do not hide these changes inside polished rewritten text.

Recommended short note:

```md
Meaningful changes
- <change 1>
- <change 2>
```

Use only when relevant.

---

# Escalation chooser

| If the issue is mainly about... | Escalate conceptually toward... |
|---|---|
| fuzzy product need | upstream product framing |
| unstable workflow or user flow | workflow / UX design |
| UX-dependent behavior with no UX yet designed | upstream `workflow-ui-ux-advisor` work |
| unresolved technical responsibility | architecture decision |
| sensitive access rule | explicit validation |
| source conflict with business impact | explicit validation and source review |
| scope expansion | upstream product/spec decision |

Do not offload casually. Only escalate when the spec writer would otherwise have to invent.

---

# Anti-pattern guardrail

Never choose a cleaner-looking output over a more truthful one.

Examples of wrong behavior:
- writing a complete-looking spec that hides unresolved business choices
- revising a feature elegantly while changing its contract
- using current code to fill major gaps
- making permissions "practical" instead of documented
- treating scope changes as harmless additions

---

# Final rule

When unsure, prefer this order:

1. preserve validated intent
2. keep permissions narrow
3. keep scope tight
4. draft conservatively
5. make unresolved structural points visible
