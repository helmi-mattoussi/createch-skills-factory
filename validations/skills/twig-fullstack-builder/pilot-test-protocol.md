# Pilot Test Protocol - twig-fullstack-builder

## Purpose

This protocol evaluates whether `twig-fullstack-builder` can consume a real Createch build packet without inventing structure, behavior, or cross-module ownership.

It is a controlled validation protocol.
It does not replace a true Symfony workspace replay.

## Expected input packet

Minimum required inputs:
- one Module Architecture Document
- validated `.feature` files for that module
- applicable readiness or ambiguity documents only when they already carry explicit conservative build assumptions

Optional project packet inputs:
- project-level feature-readiness decision
- project runbook defining multi-module sequence

## Execution modes

### Mode A - Single-module dry run

Goal:
- verify that the builder can derive a grounded file tree, coverage map, and security enforcement plan from one complete module packet

Expected outcome:
- no invented entity, route, or service structure
- all scenarios and permissions traceable

### Mode B - Multi-module slice dry run

Goal:
- verify that the builder resists merging multiple modules into one invented package

Expected outcome:
- explicit split into one invocation per module
- grounded handling of shared shell code only where upstream artifacts already allow it

## Scoring

### A. Contract intake

1. The builder reads one explicit module packet at a time.
2. The 4 implementation-contract decisions are applied exactly.
3. Conservative assumptions are consumed only when explicitly documented upstream.
4. Structural stop conditions stay visible.

### B. Generation discipline

5. The output structure matches the implementation contract.
6. The file plan stays inside module ownership.
7. Permissions are enforced without broadening access.
8. State handling matches the grounded transition model.

### C. Handoff quality

9. The output reduces builder-time invention rather than hiding it.
10. The output exposes cross-module dependencies explicitly.
11. The output provides scenario-to-file coverage visibility.
12. Remaining gaps are marked instead of silently absorbed.

## Result scale

- `pass`
- `pass with minor gaps`
- `rework required`

Use `pass with minor gaps` when the dry run is structurally sound but does not yet prove real generated code quality in a Symfony workspace.
