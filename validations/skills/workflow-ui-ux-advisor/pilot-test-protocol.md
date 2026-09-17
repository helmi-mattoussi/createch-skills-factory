# Pilot Test Protocol - workflow-ui-ux-advisor

## Purpose

This protocol validates `workflow-ui-ux-advisor` on two dimensions:

- local UX design quality
- downstream handoff quality toward `sdd-spec-writer`

The skill is not considered successful only because the UX note looks complete.
It is successful only if the UX note removes the need for the spec writer to invent triggers, navigation, UI states, or actor-visible interaction rules.

## Recommended first test

Use this first run:

- test case: `TC-01`
- mode: design mode
- upstream input: `validations/skills/brief-to-product-docs/tc-04-product-framing-dossier.md`
- downstream consumer target: `sdd-spec-writer`

Why this run:

- the framing is already stable and explicit
- actor boundaries are clear
- permission and confirmation behavior are already grounded
- the run isolates UX design quality instead of re-testing product framing

## Test input

Use:

- `validations/skills/brief-to-product-docs/tc-04-product-framing-dossier.md`

Do not enrich the framing before the first run.
If the UX skill needs assumptions, those assumptions must be visible in the output.

## Expected primary output

The skill should produce one UX Design Note aligned with:

- `skills/workflow-ui-ux-advisor/references/ux-output-template.md`

The output must stay at interaction design level.
It must not produce:

- `.feature` scenarios
- backend architecture
- API design
- implementation guidance

## Execution steps

### Step 1 - Run the skill on the Product Framing Dossier

Give the skill only:

- `validations/skills/brief-to-product-docs/tc-04-product-framing-dossier.md`

Expected posture:

- design the user journey
- make triggers and exit paths explicit
- make role visibility explicit
- keep screen-level behavior precise enough for specification

### Step 2 - Review the UX note locally

Check the UX note against the scoring grid below.

Do not decide promotion from formatting quality.
Decide based on whether the note is operational for `sdd-spec-writer`.

### Step 3 - Review downstream handoff readiness

Check whether the UX note leaves any of these to invention:

- trigger location for the flow
- key screens or views
- navigation sequence
- state-dependent visibility
- permission-dependent visibility
- error or refusal interaction pattern

If the UX note leaves those implicit, the handoff is not ready.

### Step 4 - Record the result

Fill:

- `test-run-template.md`

The run is not complete until handoff observations are recorded.

## Scoring grid

Score each item as:

- `Pass`
- `Minor gap`
- `Fail`

### A. User journey quality

1. Nominal path is explicit and step-by-step
2. At least one meaningful failure or refusal path is explicit
3. Entry trigger is explicit
4. End state is explicit

### B. Screen structure quality

5. Each in-scope screen or view is described
6. Key elements are explicit enough for specification
7. Exit paths are explicit
8. The UX note does not drift into visual design or implementation

### C. Interaction contract quality

9. Relevant UI states are explicit
10. Forbidden transitions are explicit when relevant
11. Actor and permission visibility are explicit
12. UX edge cases are explicit where they materially affect behavior

### D. Handoff quality

13. `May assume` is explicit enough for `sdd-spec-writer`
14. `Must not invent` is explicit enough for `sdd-spec-writer`
15. `Still needs to specify` is explicit and correctly bounded
16. The spec writer would not need to invent triggers, navigation, or state-dependent interaction

## Pass / fail rule

The run passes only if:

- no item is marked `Fail`
- no more than 3 items are marked `Minor gap`
- the UX note stays at interaction level
- the handoff is operational for downstream specification

The run is `rework required` if:

- the UX note invents product rules not in framing
- the UX note omits the user journey
- the UX note omits key screens or trigger locations
- the handoff leaves core navigation or state interaction for the next skill to invent

## Promotion guidance

Do not promote `workflow-ui-ux-advisor` to `pilot-validated` from this run alone unless:

- the UX note passes locally
- downstream handoff quality is explicit and strong
- the result is recorded in `test-run-template.md`
- more than one mode or situation type has been exercised
