# Decision Matrix

## Recommend `PASS`

Use when:
- the reviewed path is structurally safe enough for the intended scope
- obvious hot-path blockers are absent
- current safeguards are sufficient for release

## Recommend `PASS WITH EXPLICIT FOLLOW-UPS`

Use when:
- the release is safe for current scope
- growth or optimization watch items remain visible
- remaining concerns do not make the current release unsafe

## Recommend `REWORK`

Use when:
- obvious scale or latency risk is already unsafe for intended scope
- the unit lacks a basic guardrail on a clearly risky path
- structural risk is being hidden behind vague "optimize later" language
