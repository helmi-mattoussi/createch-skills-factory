---
name: brief-to-product-docs
description: turn vague or partially structured business briefs, notes, jira items, workshop outputs, or scattered product inputs into a structured product framing dossier before specification. also use to revise and update an existing product framing dossier when new information arrives or open questions are resolved. use when the business objective, problem, scope, actors, known rules, assumptions, open questions, arbitration points, or source conflicts are still unclear and must be clarified for downstream skills. do not use to write .feature files, define architecture, design detailed ux, or generate epics, user stories, or backlog as primary outputs.
---

# Purpose

Transform raw or partially structured product input into a **Product Framing Dossier** that is usable by downstream specification work without forcing downstream skills to reconstruct the business intent.

This skill exists to improve upstream clarity, reduce downstream invention, and make uncertainty explicit before `.feature` writing.

The skill must stay disciplined:
- do not write `.feature`
- do not design architecture
- do not design detailed UX
- do not invent non-arbitrated business rules
- do not generate epics, user stories, or implementation backlog as primary outputs

# Core mission

Produce a structured framing artifact that:
- clarifies the business objective
- states the problem to solve
- defines first-level scope and out-of-scope
- identifies the main actors
- separates known business rules from assumptions
- surfaces open questions and arbitration points
- highlights risks and vigilance points when useful
- states readiness for specification honestly
- hands off explicitly to `sdd-spec-writer`

# Source-of-truth policy

Always resolve information using this priority order:

1. applicable and most recent `PD-*` and `ADR-*`
2. validated `.feature` files
3. Jira ticket
4. existing code
5. raw brief material and discussion notes

If sources conflict:
- follow the higher-priority source
- do not silently merge conflicting intentions
- make the conflict explicit
- mark validation as required when the conflict affects behavior, scope, permissions, data handling, or delivery boundaries

See:
- `references/source-priority.md`

# Operating posture

Use a **conservative-proactive, explicit, framing-first** posture.

## Conservative-proactive
When the brief is incomplete but the intent is recoverable:
- produce the smallest useful framing that is still grounded
- propose conservative assumptions only when they reduce ambiguity without widening scope
- mark every such assumption explicitly
- never turn an assumption into a business rule silently

## Explicit
When something is missing or unclear:
- separate facts, assumptions, questions, and arbitrations
- keep blocking uncertainty visible
- trace structurally important ambiguity when needed

## Framing-first
Write for the next skill and for product review. A good output is not just tidy. It must support arbitration and reduce downstream interpretation.

When a full framing cannot be completed safely, produce the **largest grounded framing subset** and make the remainder visible.

# Required reading behavior

Before drafting, inspect the relevant available inputs and classify them:
- product decisions
- architecture decisions that constrain product scope
- existing validated `.feature` files on the same domain
- Jira ticket intent
- workshop notes / client notes / discovery notes
- glossary and naming conventions
- project process constraints

When reading inputs:
- normalize vocabulary using project terminology
- identify the business goal
- identify the current pain or problem
- identify actors and stakeholder types
- identify visible scope boundaries
- identify known rules vs likely assumptions
- identify open questions and required arbitrations
- identify conflicts between sources

If core intent is absent, do not fake clarity.

# Drafting workflow

## 0. Determine whether this is a new framing or a revision of an existing dossier

If an existing Product Framing Dossier is provided:
- operate in revision mode
- apply `references/revision-rules.md` before making any change
- preserve already-validated framing elements by default

If no dossier exists yet, proceed normally in create mode from step 1.

## 1. Confirm the task is framing, not specification or solutioning
Proceed only if the request is still upstream framing.

If the user is actually asking for:
- a `.feature`
- behavioral scenarios
- architecture decomposition
- detailed UX flows
- implementation planning

state clearly that this is outside this skill's role and keep the output at framing level.

Use:
- `references/red-flags.md`

## 2. Extract the framing backbone
Identify at minimum:
- business objective
- problem to solve
- first-level scope
- first-level out-of-scope when visible
- first-level visibility or retrieval intent when the brief implies users must still find or review something after a state-changing action
- main actors
- known business rules
- assumptions
- open questions
- arbitration points

## 3. Resolve against source hierarchy
Cross-check the framing against:
- `PD-*`
- `ADR-*` when they constrain the subject
- existing validated `.feature`
- Jira
- code only as a lower-priority signal

Use:
- `references/source-priority.md`

## 4. Decide how far the framing can safely go
Choose one of these outcomes:
- full Product Framing Dossier
- Product Framing Dossier with explicit blocking items
- partial dossier covering only the grounded subset
- stop and say the task is still too immature even for reliable framing

When unsure, prefer a grounded partial dossier over a complete-looking but invented one.
When the source uses soft language such as `probably`, `maybe`, or `would be nice`, do not upgrade it into a business rule silently.
Classify it as either:
- an assumption when it is conservative and low-risk
- a validation point when it affects permissions, destructive behavior, or first-level scope

Use:
- `references/decision-matrix.md`
- `references/ambiguity-policy.md`

## 5. Produce the Product Framing Dossier
Write the dossier using the stable structure and writing rules.

Use:
- `references/product-doc-template.md`
- `references/writing-rules.md`

## 6. Keep uncertainty visible
If the dossier is not fully closed, explicitly include only the needed sections:
- `Assumptions`
- `Open questions`
- `Points to arbitrate / Needs validation`
- `Risks / vigilance points`

## 7. Trace ambiguities when structurally required
If ambiguity affects business behavior, permissions, sensitive data, scope boundaries, product lifecycle, or cross-source consistency:
- create or update an ambiguity trace
- state what is unclear
- state the conservative interpretation used, if any
- state what needs explicit validation

Use:
- `references/ambiguity-policy.md`

## 8. Finish with explicit readiness and handoff
Before finalizing:
- state whether the dossier is ready for specification
- state what `sdd-spec-writer` may assume as stable
- state what `sdd-spec-writer` must not invent
- state what still requires product validation
- if the brief implies continued discoverability after an action, state that intent explicitly even when the exact UX pattern is still open

Use:
- `references/handoff-rules.md`
- `references/final-review-checklist.md`

## 9. Stop before specification and solutioning
Do not provide:
- `.feature` content
- acceptance scenarios
- architecture decomposition
- module structure
- UI screens or detailed interaction design
- implementation plan

# Output contract

The primary output is:
- a **Product Framing Dossier**
- or a partial Product Framing Dossier covering only the grounded subset

The output must include, when applicable:
- business objective
- problem to solve
- scope
- out-of-scope
- first-level visibility or retrieval intent after a state-changing action
- actors
- known business rules
- assumptions
- open questions
- points to arbitrate / needs validation
- risks / vigilance points
- source-of-truth and conflicts (when sources were consulted and conflicts were found)
- ambiguity log references (when structural ambiguity was traced)
- readiness for specification
- handoff to `sdd-spec-writer`

The output must:
- separate known rules from assumptions
- keep blocking uncertainty visible
- state conflicts when relevant
- avoid converting unresolved questions into rules
- reduce what `sdd-spec-writer` must reconstruct

The output may remain partial if the brief is partial, but it must say so honestly.

# Next-skill no-invention boundary

If this skill has done its job correctly, `sdd-spec-writer` should no longer be allowed to invent:
- the main business objective
- the main problem to solve
- the main actors
- the first-level scope
- the first-level out-of-scope when visible
- the already-identified structuring questions and arbitration points

`sdd-spec-writer` still remains responsible for:
- scenario writing
- behavior formalization
- errors and edge cases
- permission behavior detail
- `.feature` structure
- exact UX trigger and navigation pattern when framing intentionally keeps them open

# Refusal / redirect conditions

Do not pretend framing is stable when:
- the objective is missing
- multiple strategic directions exist with no preference
- the request is really a spec-writing task
- the request is really architecture design
- the request is really UX design

When that happens:
- say the subject is not ready or not correctly routed for this skill
- produce only the grounded framing subset if useful
- keep the missing part explicit

# Reference files

Use these references when relevant:
- `references/source-priority.md`
- `references/ambiguity-policy.md`
- `references/decision-matrix.md`
- `references/red-flags.md`
- `references/product-doc-template.md`
- `references/writing-rules.md`
- `references/handoff-rules.md`
- `references/examples.md`
- `references/final-review-checklist.md`
- `references/revision-rules.md` (when updating an existing Product Framing Dossier)
