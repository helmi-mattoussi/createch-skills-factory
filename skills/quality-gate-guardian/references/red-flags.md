# Red Flags

Use these as blockers or escalation signals during quality review.

## RF-001 Ungrounded behavior
- code implements behavior not covered by any validated `.feature`

## RF-002 Missing permission enforcement
- covered actions lack visible or server-side permission checks

## RF-003 Happy-path-only validation
- nominal path works but failure or rejection behavior is unverified

## RF-004 Missing critical evidence
- no credible tests or manual proof exist for core scenarios

## RF-005 Hidden upstream drift
- review reveals spec, architecture, or product truth is wrong but implementation continues anyway

## RF-006 Lateral risk hidden in generic review
- a security, reliability, or performance issue is discovered but not escalated to the proper specialist review
