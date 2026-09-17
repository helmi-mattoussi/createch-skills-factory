# Decision Matrix

## Recommend `PASS`

Use when:
- permission behavior matches validated sources
- no blocking sensitive-data risk is visible
- destructive actions are properly guarded
- evidence is credible for the reviewed scope

## Recommend `PASS WITH EXPLICIT FOLLOW-UPS`

Use when:
- the reviewed release is acceptably safe
- remaining items are hardening or traceability improvements, not active blockers

Examples:
- add an extra denial-path test
- improve log redaction coverage for non-critical paths

## Recommend `REWORK`

Use when:
- access is broader than specified
- sensitive data may be exposed to the wrong actor
- destructive actions lack proper safeguards
- critical evidence is missing for the sensitive scope
