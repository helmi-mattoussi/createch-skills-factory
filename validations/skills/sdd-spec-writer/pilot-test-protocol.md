# Pilot Test Protocol - sdd-spec-writer

## Purpose

This protocol validates `sdd-spec-writer` on two dimensions:

- local specification quality
- downstream handoff quality toward builders

The skill is not considered successful only because the `.feature` looks clean.
It is successful only if the `.feature` gives builders a usable behavioral contract without forcing them to invent core rules, permissions, or state restrictions.

## Recommended first test

Use this first run:

- test case: `TC-01`
- mode: create mode
- input framing dossier: `validations/skills/brief-to-product-docs/tc-04-product-framing-dossier.md`
- input UX note: `validations/skills/workflow-ui-ux-advisor/tc-01-ux-design-note.md`
- downstream consumer target: builders

Why this run:

- upstream framing is already validated
- the UX note already closes trigger, screen, navigation, and visibility gaps
- the run isolates specification quality instead of re-testing product framing or UX design

## Test input

Use only:

- `validations/skills/brief-to-product-docs/tc-04-product-framing-dossier.md`
- `validations/skills/workflow-ui-ux-advisor/tc-01-ux-design-note.md`

Do not enrich the input before the first run.
If the skill needs an assumption, that assumption must be visible and justified.

## Expected primary output

The skill should produce:

- one implementation-ready `.feature`

The output should follow the discipline described in:

- `skills/sdd-spec-writer/references/feature-template.md`
- `skills/sdd-spec-writer/references/spec-writing-rules.md`

The output must stay at behavioral contract level.
It must not produce:

- architecture design
- implementation code
- API schema design
- UI design rationale

## Execution steps

### Step 1 - Run the skill on the validated inputs

Give the skill only:

- `validations/skills/brief-to-product-docs/tc-04-product-framing-dossier.md`
- `validations/skills/workflow-ui-ux-advisor/tc-01-ux-design-note.md`

Expected posture:

- write a full `.feature`
- make business rules explicit
- make permissions explicit
- cover nominal, refusal, and important state behaviors

### Step 2 - Review the `.feature` locally

Check the `.feature` against the scoring grid below.

Do not decide promotion from formatting quality.
Decide based on whether a builder could implement the behavior without inventing core rules.

### Step 3 - Review downstream handoff readiness

Check whether the `.feature` still leaves any of these to invention:

- core business rules
- permission model
- state restrictions
- confirmation requirement
- main nominal outcome
- important refusal behavior

If the `.feature` leaves those implicit, the handoff is not ready.

### Step 4 - Record the result

Fill:

- `test-run-template.md`

The run is not complete until downstream handoff observations are recorded.

## Scoring grid

Score each item as:

- `Pass`
- `Minor gap`
- `Fail`

### A. Contract completeness

1. Business goal and feature boundary are explicit
2. Business rules are explicit and reusable across scenarios
3. Permissions are explicit and not left to inference
4. Nominal, refusal, and important state behavior are covered

### B. Specification quality

5. Scenarios describe observable behavior
6. Vocabulary is consistent with upstream framing and UX note
7. The `.feature` does not drift into architecture or implementation detail
8. `Out of scope` is explicit when drift risk exists

### C. Handoff quality

9. Builders would not need to invent the main behavior
10. Builders would not need to invent the permission model
11. Builders would not need to invent state restrictions or forbidden transitions
12. Any unresolved point is explicit and correctly bounded

## Pass / fail rule

The run passes only if:

- no item is marked `Fail`
- no more than 3 items are marked `Minor gap`
- the `.feature` stays at behavioral contract level
- the handoff is operational for downstream builders

The run is `rework required` if:

- the `.feature` invents product behavior not grounded upstream
- permissions are widened or left implicit
- state restrictions are missing when lifecycle matters
- the output covers only the happy path
- builders would still need to invent core behavior

## Promotion guidance

Do not promote `sdd-spec-writer` to `pilot-validated` from this run alone unless:

- the `.feature` passes locally
- downstream builder handoff quality is explicit and strong
- the result is recorded in `test-run-template.md`
- more than one mode or situation type has been exercised
