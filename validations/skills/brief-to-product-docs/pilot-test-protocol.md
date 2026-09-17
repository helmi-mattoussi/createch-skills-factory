# Pilot Test Protocol - brief-to-product-docs

## Purpose

This protocol validates `brief-to-product-docs` on two dimensions:

- local framing quality
- downstream handoff quality

The skill is not considered successful only because it produces a clean dossier.
It is successful only if the next skill can consume that dossier without reconstructing the business intent.

## Recommended first test

Use this first run:

- test case: `TC-01` plus `TC-06`
- mode: create mode
- downstream consumer: `workflow-ui-ux-advisor`
- fallback downstream consumer: `sdd-spec-writer`

Why this combination:

- `TC-01` checks whether the skill can clean up a messy but understandable brief
- `TC-06` checks whether the handoff is explicit enough for the next skill

## Test input

Use:

- `fixtures/tc-01-messy-invoice-archive-brief.md`

Do not enrich the brief before the first run.
If the skill needs to mark assumptions or open questions, that is part of the test.

## Expected primary output

The skill should produce one Product Framing Dossier aligned with:

- `skills/brief-to-product-docs/references/product-doc-template.md`

The output must stay at framing level.
It must not produce:

- `.feature` scenarios
- architecture decomposition
- UX screens or detailed flows
- implementation tasks

## Execution steps

### Step 1 - Run the skill on the raw brief

Give the skill only:

- `fixtures/tc-01-messy-invoice-archive-brief.md`

Expected posture:

- extract the business objective
- separate known rules from assumptions
- surface ambiguity instead of hiding it
- define first-level scope and first-level out-of-scope
- produce an honest readiness assessment

### Step 2 - Review the framing output locally

Check the dossier against the scoring grid below.

Do not yet decide validation status.
First verify whether the output is usable by the next skill.

### Step 3 - Run the downstream handoff test

Give the produced dossier to `workflow-ui-ux-advisor`.

Ask the downstream skill to produce its normal output while observing:

- whether it had to infer actors
- whether it had to invent first-level scope
- whether it had to guess the main business objective
- whether it had to reinterpret open questions as settled facts

If `workflow-ui-ux-advisor` is not available for the run, use `sdd-spec-writer`.

### Step 4 - Record the result

Fill:

- `test-run-template.md`

The run is not complete until the handoff observations are written down.

## Scoring grid

Score each item as:

- `Pass`
- `Minor gap`
- `Fail`

### A. Framing quality

1. Business objective is explicit and business-facing
2. Problem to solve is explicit and distinct from the solution
3. In-scope items are clear and bounded
4. Out-of-scope items are visible where reasonably inferable
5. Primary actor is explicit
6. Known business rules are separated from assumptions
7. Open questions are visible
8. Arbitration points are visible
9. Readiness for specification is honest
10. Output stayed at framing level

### B. Source and conflict discipline

11. The dossier does not silently invent rules missing from the brief
12. Conservative assumptions are marked as assumptions
13. The dossier does not drift into UX, spec, or architecture

### C. Handoff quality

14. `May assume` is explicit enough for the next skill
15. `Must not invent` is explicit enough for the next skill
16. Blocking uncertainties are visible before handoff
17. The next skill can start without reconstructing core business intent

## Mandatory handoff checklist

The handoff fails if any of these are missing or unclear:

- main business objective
- main problem to solve
- main actor
- first-level scope
- first-level out-of-scope when visible
- already identified open questions
- already identified arbitration points
- explicit `May assume`
- explicit `Must not invent`

## Pass / fail rule

The run passes only if:

- no item in sections A, B, or C is marked `Fail`
- no more than 3 items are marked `Minor gap`
- the downstream consumer does not reconstruct core intent

The run is `rework required` if:

- the skill writes pseudo-specification instead of framing
- the main actor or main objective is missing
- known rules and assumptions are merged
- the downstream skill has to reconstruct scope or actors

## What to learn from the first run

If the output is good locally but weak downstream:

- improve handoff wording
- strengthen the no-invention boundary
- make scope or actor language more explicit

If the output already fails locally:

- improve the framing template usage
- improve ambiguity handling
- improve anti-drift discipline

## Promotion guidance

Do not promote `brief-to-product-docs` to `pilot-validated` from this run alone unless:

- the dossier passed locally
- the downstream handoff passed
- the result is recorded in `test-run-template.md`
- the related `validation-status.md` is updated with evidence, not opinion
