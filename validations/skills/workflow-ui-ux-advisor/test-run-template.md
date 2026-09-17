# Test Run Template - workflow-ui-ux-advisor

## Run metadata

- Date:
- Reviewer:
- Skill mode: `design` / `revise`
- Input framing dossier:
- Downstream consumer target: `sdd-spec-writer`

## Output reviewed

- UX Design Note path:

## Scoring

### A. User journey quality

1. Nominal path is explicit and step-by-step:
2. At least one meaningful failure or refusal path is explicit:
3. Entry trigger is explicit:
4. End state is explicit:

### B. Screen structure quality

5. Each in-scope screen or view is described:
6. Key elements are explicit enough for specification:
7. Exit paths are explicit:
8. The UX note does not drift into visual design or implementation:

### C. Interaction contract quality

9. Relevant UI states are explicit:
10. Forbidden transitions are explicit when relevant:
11. Actor and permission visibility are explicit:
12. UX edge cases are explicit where they materially affect behavior:

### D. Handoff quality

13. `May assume` is explicit enough for `sdd-spec-writer`:
14. `Must not invent` is explicit enough for `sdd-spec-writer`:
15. `Still needs to specify` is explicit and correctly bounded:
16. The spec writer would not need to invent triggers, navigation, or state-dependent interaction:

## Handoff observations

- What the spec writer can now consume directly:
- What would still force invention:
- Were any product decisions invented by the UX note:
- Is the handoff section operational:

## Final decision

- Result: `pass` / `pass with minor gaps` / `rework required`
- Main strengths:
- Main gaps:
- Recommended skill changes:
- Promotion impact: `no change` / `candidate for pilot-validated after more evidence`
