---
name: workflow-ui-ux-advisor
description: design user workflows, interaction flows, screen structures, UI states, form structures, navigation logic, and UX edge cases from a validated product framing dossier. use when a feature or business flow requires interaction design before specification, when sdd-spec-writer would otherwise need to invent screen triggers, navigation sequences, or UI state transitions. also use to revise an existing UX design note when product framing or product decisions have changed. do not use to write .feature files, make product decisions, define backend architecture, or write implementation code.
---

# Purpose

Transform a validated Product Framing Dossier into a UX Design Note that describes how a business flow is experienced by its users, so that `sdd-spec-writer` can write behaviorally precise `.feature` files without inventing interaction design.

This skill exists to bridge the gap between **what the product must do** (framing) and **what the product must specify** (behavioral contract).

Without this skill, `sdd-spec-writer` is forced to invent screen triggers, navigation flows, UI states, and form logic — which is out of its scope and silently adds unvalidated product behavior.

The skill must stay disciplined:
- do not write `.feature` content
- do not make product decisions unilaterally
- do not define technical or backend architecture
- do not invent business rules not in the framing
- do not design full visual design systems or style guides

---

# Core mission

Produce a **UX Design Note** (or revise an existing one) that:
- describes the user journey for the covered flow
- defines the screen structure and key elements
- specifies UI states and their transitions
- specifies form structures, fields, and validation behavior
- describes the navigation flow between screens or steps
- identifies UX edge cases relevant to the behavioral contract
- surfaces UX constraints from PD-* and ADR-*
- makes visible what `sdd-spec-writer` may assume and must not invent

---

# Operating posture

The skill operates in two modes.

## Mode 1 — Design mode

Used when no UX Design Note exists yet for the covered flow.

The skill:
- reads the Product Framing Dossier as primary input
- reads applicable PD-* and ADR-* for constraints
- designs the UX flow, screen structure, UI states, and forms
- keeps UX choices grounded in validated product framing
- surfaces unresolved UX decisions rather than inventing them
- produces a UX Design Note ready for `sdd-spec-writer` consumption

## Mode 2 — Revise mode

Used when a UX Design Note already exists and must be updated.

The skill:
- reads the existing UX Design Note
- identifies what has changed in the framing or product decisions
- updates only what is grounded in the change
- preserves validated UX decisions by default
- makes changed interaction choices visible explicitly

---

# Trigger conditions

## Use this skill when

- the Product Framing Dossier exists and the Product Quality Gate passed
- the feature or flow involves user interaction, navigation, or form behavior
- `sdd-spec-writer` would need to invent screen triggers or navigation to write the spec
- there is no UX Design Note yet for this flow
- an existing UX Design Note must be updated after a framing or product decision change

## Do not use this skill when

- the business need has not yet been framed (use `brief-to-product-docs` first)
- the Product Quality Gate has not yet been passed
- the feature has no user-facing interaction (purely automated backend behavior)
- the task is to write `.feature` (use `sdd-spec-writer`)
- the task is to define backend architecture (use `module-architecture-advisor`)

---

# Required reading behavior

Before designing, read in this order:

1. Product Framing Dossier for the covered flow
2. Applicable `PD-*` — especially those affecting scope, actors, or permissions
3. Applicable `ADR-*` — especially those affecting UI behavior, navigation, or data display constraints
4. Validated `.feature` if they exist for adjacent behaviors
5. Jira ticket if additional context is needed
6. Any existing UX Design Note if revising

Use:
- `references/source-priority.md`

---

# Drafting workflow

## Step 0 — Determine mode

If a UX Design Note already exists for the covered flow:
- operate in revise mode
- apply `references/revision-rules.md` before making any change
- preserve validated UX decisions by default

If no UX Design Note exists yet, proceed in design mode from step 1.

---

## Step 1 — Check that the flow is ready for UX design

Confirm:
- a Product Framing Dossier exists for this flow
- the main actors are identified
- the first-level scope is clear enough to design interaction
- there are no unresolved product arbitrations that block UX design

If the framing is not ready:
- say so explicitly
- do not design UX for a flow that is still undecided at the product level
- redirect to `brief-to-product-docs` if needed

Use:
- `references/red-flags.md`

---

## Step 2 — Check source priority and constraints

Before designing:
- check applicable PD-* for product constraints that affect UX
- check applicable ADR-* for technical constraints that affect UI behavior
- identify any existing `.feature` for adjacent flows (to stay consistent)

If sources conflict, surface the conflict rather than resolving it silently.

Use:
- `references/source-priority.md`

---

## Step 3 — Design the user journey

Describe the user's path through the flow, step by step:
- what triggers entry into the flow
- what the user does at each step
- what the system responds with
- how the flow ends (success and failure paths)

Keep the journey grounded in validated framing.
Do not invent actors or flows not supported by the framing.

---

## Step 4 — Design the screen structure

For each screen or view in the flow:
- identify the entry trigger
- describe the key layout elements (sections, lists, forms, actions)
- describe the actions available on the screen
- describe the exit paths (next screen, error, back)

If a screen depends on a UX decision not yet made, mark it as `Needs validation`.

---

## Step 5 — Define UI states and transitions

For each entity or screen that has multiple states:
- list the relevant states
- describe how transitions occur
- mark forbidden transitions explicitly when relevant

Do not invent state transitions not supported by product framing or PD-*.

---

## Step 6 — Define forms and field structures if applicable

For each form in the flow:
- list the fields
- state field type and validation behavior
- describe submission behavior (success, validation error, system error)
- describe which fields are required vs optional

Do not invent business validation rules not in the framing.

---

## Step 7 — Govern ambiguity and surface decisions

When UX choices cannot be made without a product or architecture decision:
- do not invent silently
- mark the point as a UX decision that requires product validation
- provide a conservative placeholder when useful
- create an ambiguity trace if the uncertainty materially affects the downstream spec

Use:
- `references/ambiguity-policy.md`
- `references/decision-matrix.md`

---

## Step 8 — Complete the handoff section

Before finalizing:
- state what `sdd-spec-writer` may now assume as stable
- state what `sdd-spec-writer` must not still need to invent
- state what remains unresolved and requires upstream or parallel validation

Use:
- `references/final-review-checklist.md`

---

## Step 9 — Stop before specification and architecture

Do not provide:
- `.feature` content or Gherkin scenarios
- acceptance criteria or test scenarios
- technical architecture or module structure
- backend implementation guidance
- database schema

---

# Input contract

Primary inputs:
- Product Framing Dossier (required)
- applicable `PD-*` (required when available)
- applicable `ADR-*` (required when available)
- existing UX Design Note (required in revise mode)
- validated `.feature` for adjacent flows (optional, for consistency)
- Jira ticket (optional, as context)

The skill must not proceed without at least:
- a Product Framing Dossier with explicit scope and main actors
- a passed Product Quality Gate (or explicit acknowledgment that framing is stable enough)

---

# Output contract

Primary output:
- a **UX Design Note**
- or a partial UX Design Note covering only the stable subset
- or a companion note explaining what is missing and why UX design cannot proceed

The output must include when applicable:
- context (flow title and source framing reference)
- in-scope and out-of-scope (UX level)
- user journey
- screen structure (per screen)
- UI states and transitions
- form structure (when forms are involved)
- navigation flow
- UX edge cases
- UX constraints (from PD-* and ADR-*)
- assumptions
- needs validation (unresolved UX decisions)
- handoff to `sdd-spec-writer`

The output must:
- stay at the interaction design level (not implementation level)
- separate validated design choices from UX assumptions
- surface unresolved decisions explicitly
- reduce what `sdd-spec-writer` must still invent or guess

Use:
- `references/ux-output-template.md`
- `references/writing-rules.md`

---

# No-invention boundaries

## This skill must not invent

- business rules not in the Product Framing Dossier
- actors not identified in the framing
- permission models not validated by a PD-*
- product scope extensions not in the framing
- technical architecture decisions

## sdd-spec-writer must not still need to invent after this skill

- which screen or view triggers the action being specified
- what the navigation sequence is for the covered flow
- what happens visually when a key state changes
- what fields appear on a form and what their validation behavior is
- what happens at UX-level on error (which message, which visual state)
- what the exit paths are from a key screen

If `sdd-spec-writer` would still need to invent these, the UX Design Note is not complete.

---

# Interaction boundaries with other skills

## Upstream neighbors
- `brief-to-product-docs`: produces the Product Framing Dossier that this skill uses as primary input
- `saas-solution-architect`: may produce architecture constraints that affect navigation or UI structure

## Downstream neighbor
- `sdd-spec-writer`: primary consumer of UX Design Note outputs

## Lateral neighbors
- `module-architecture-advisor`: may produce technical constraints affecting UI behavior (e.g., pagination strategy, async behavior)

## Rules

This skill does not replace product framing.
This skill does not replace specification.
This skill provides the interaction design inputs that connect framing to specification.

If the task requires product discovery → redirect to `brief-to-product-docs`.
If the task requires `.feature` writing → redirect to `sdd-spec-writer`.
If the task requires technical architecture → redirect to `module-architecture-advisor`.

---

# Autonomy rules

The skill may decide alone when:
- the UX choice is a low-risk interaction convention (e.g., standard form layout)
- the choice follows directly from the validated framing
- the choice does not affect permissions, scope, or business rules
- the assumption is conservative and can be stated explicitly

The skill must surface and require validation when:
- a UX choice implies a product decision not yet validated
- a UX choice affects who sees what (visibility and permission)
- a UX choice implies a navigation path not explicitly in the framing
- a UX choice affects destructive or irreversible actions
- two valid UX directions exist and both affect the behavioral contract

---

# Reference files

Use these references when relevant:
- `references/source-priority.md`
- `references/red-flags.md`
- `references/ambiguity-policy.md`
- `references/decision-matrix.md`
- `references/ux-output-template.md`
- `references/writing-rules.md`
- `references/examples.md`
- `references/final-review-checklist.md`
- `references/revision-rules.md` (in revise mode)

---

# Minimal checklist before finalizing

Before delivering the UX Design Note:

- [ ] User journey covers both success and failure paths
- [ ] All screens in scope are described with their key elements
- [ ] UI states are explicit when behavior depends on them
- [ ] Forbidden state transitions are flagged when relevant
- [ ] Form fields and validation are described when forms exist
- [ ] Navigation flow is clear and does not require invention
- [ ] UX edge cases are considered
- [ ] UX constraints from PD-*/ADR-* are respected
- [ ] Unresolved UX decisions are marked as Needs validation
- [ ] Handoff to sdd-spec-writer is explicit and complete
- [ ] The output does not contain .feature content
- [ ] The output does not contain architecture or implementation guidance

Use:
- `references/final-review-checklist.md`
