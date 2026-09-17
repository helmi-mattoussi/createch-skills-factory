# Test Cases - release-rollout-advisor

Each test case defines the review packet, the expected rollout behavior, and the expected recommendation.

---

## TC-01 - Clean low-risk release

Input:
- quality review `PASS`
- no security review needed
- no migration and no rollout complication

Expected behavior:
- recommends direct release
- final recommendation is `READY FOR RELEASE`

Expected output:
- Release Rollout Recommendation with low-risk direct rollout

Status: not yet executed

---

## TC-02 - Managed-risk release with watch items

Input:
- quality review `PASS`
- security review `PASS WITH EXPLICIT FOLLOW-UPS`
- rollout requires a feature flag or staged enablement

Expected behavior:
- keeps the release allowed
- surfaces watch items explicitly
- final recommendation is `READY FOR RELEASE WITH WATCH ITEMS`

Expected output:
- Release Rollout Recommendation with managed-risk rollout

Status: not yet executed

---

## TC-03 - Missing quality gate

Input:
- implementation exists
- no quality review output

Expected behavior:
- blocks release planning
- final recommendation is `HOLD`

Expected output:
- Release Rollout Recommendation with missing-upstream-review blocker

Status: not yet executed

---

## TC-04 - Migration without credible rollback

Input:
- quality review passed
- release requires migration
- rollback expectations are not credible or not stated

Expected behavior:
- blocks release or escalates to managed-risk only if mitigation is explicit
- final recommendation is conservative

Expected output:
- Release Rollout Recommendation with rollback blocker or hold

Status: not yet executed
