# Test Run Template - sdd-spec-writer

## Run metadata

- Date:
- Reviewer:
- Skill mode: `create` / `revise`
- Input framing dossier:
- Input UX note:
- Existing `.feature`:
- Downstream consumer target:

## Output reviewed

- `.feature` path:
- Companion note path:

## Scoring

### A. Contract completeness

1. Business goal and feature boundary are explicit:
2. Business rules are explicit and reusable across scenarios:
3. Permissions are explicit and not left to inference:
4. Nominal, refusal, and important state behavior are covered:

### B. Specification quality

5. Scenarios describe observable behavior:
6. Vocabulary is consistent with upstream framing and UX note:
7. The `.feature` does not drift into architecture or implementation detail:
8. `Out of scope` is explicit when drift risk exists:

### C. Handoff quality

9. Builders would not need to invent the main behavior:
10. Builders would not need to invent the permission model:
11. Builders would not need to invent state restrictions or forbidden transitions:
12. Any unresolved point is explicit and correctly bounded:

## Handoff observations

- What builders can now consume directly:
- What would still force invention:
- Were any product decisions invented by the spec:
- Is the builder handoff operational:

## Final decision

- Result: `pass` / `pass with minor gaps` / `rework required`
- Main strengths:
- Main gaps:
- Recommended skill changes:
- Promotion impact: `no change` / `candidate for pilot-validated after more evidence`
