# Source Priority

## System-level hierarchy (4 levels — applies to all skills)

Use this order when sources conflict:
1. applicable and most recent `PD-*` / `ADR-*`
2. validated `.feature`
3. Jira ticket
4. existing code

This is the standard project-wide hierarchy defined in the master governance reference.

## Skill-specific input level (level 5 — specific to this skill only)

5. raw brief material and discovery notes (workshop notes, client emails, support issues, etc.)

This level 5 is **specific to `brief-to-product-docs`** because raw brief material is the primary input of this skill.

It does not appear in the system-wide hierarchy used by `sdd-spec-writer` and downstream skills, which expect already-framed inputs, not raw briefs.

Raw brief material has the lowest authority. It can be used to extract intent, but:
- it must not override higher-priority sources
- conflicts between brief material and PD/ADR/feature must always surface the higher-priority source
- assumptions drawn from brief material must be explicitly labeled as assumptions

## Rules

- do not silently merge conflicting intentions
- make conflicts explicit when they affect scope, behavior, permissions, data, or delivery boundaries
- never treat existing code as final truth when higher-priority artifacts disagree
- never treat raw brief material as validated product truth
