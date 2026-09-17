# Decision Matrix

## Recommend `PASS`

Use when:
- important runtime behavior is credibly visible
- failure handling is good enough for the slice
- no meaningful silent-failure blocker remains

## Recommend `PASS WITH EXPLICIT FOLLOW-UPS`

Use when:
- runtime operation is release-safe
- watch items are visible and non-blocking
- remaining gaps do not prevent operators from diagnosing or containing issues

## Recommend `REWORK`

Use when:
- meaningful runtime behavior is effectively invisible
- silent failure risk is still hidden
- recovery expectations are not credible
- blocking upstream architecture or specification gaps remain
