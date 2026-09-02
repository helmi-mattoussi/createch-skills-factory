# Decision Matrix

## Recommend `PASS`

Use when:
- validated behavior is implemented as specified
- permissions are enforced
- core scenarios have credible evidence
- no blocking regression or drift remains

## Recommend `PASS WITH EXPLICIT FOLLOW-UPS`

Use when:
- core behavior is release-safe
- remaining items are non-blocking and visible
- follow-ups do not change expected behavior for the covered release unit

Examples:
- missing non-critical cleanup test
- minor observability improvement already tracked

## Recommend `REWORK`

Use when:
- implementation contains ungrounded behavior
- critical scenarios are unverified
- permission handling is wrong or unclear
- blocking regressions are present
- upstream artifacts must be corrected before safe release
