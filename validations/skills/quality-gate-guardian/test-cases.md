# Test Cases - quality-gate-guardian

Each test case defines the input type, the expected behavior, and the expected output pattern.

---

## TC-01 - Implementation matches validated behavior

Input:
- validated `.feature`
- implementation evidence
- tests covering nominal and permission scenarios

Expected behavior:
- review confirms behavior conformity
- no blocking drift is found
- recommendation is `PASS`

Expected output:
- Quality Gate Review with `PASS`

Status: not yet executed

---

## TC-02 - Ungrounded behavior implemented

Input:
- code contains behavior not covered by `.feature`

Expected behavior:
- review flags ungrounded behavior
- blocks release
- recommends either removal or spec revision

Expected output:
- Quality Gate Review with `REWORK`

Status: not yet executed

---

## TC-03 - Missing permission enforcement

Input:
- `.feature` defines a restricted action
- implementation allows broader access

Expected behavior:
- review flags permission drift
- recommends `REWORK`

Expected output:
- Quality Gate Review with permission blocker explicit

Status: not yet executed

---

## TC-04 - Incomplete test evidence with safe non-blocking follow-up

Input:
- behavior matches `.feature`
- one non-critical evidence gap remains

Expected behavior:
- review distinguishes non-blocking follow-up from blocker
- recommendation is `PASS WITH EXPLICIT FOLLOW-UPS`

Expected output:
- Quality Gate Review with visible follow-up list

Status: not yet executed

---

## TC-05 - Review reveals upstream spec gap

Input:
- implementation includes a legitimate edge case that should be specified
- `.feature` omitted it

Expected behavior:
- review blocks release until upstream truth is corrected
- recommends `sdd-spec-writer` revise mode

Expected output:
- Quality Gate Review with backward propagation path

Status: not yet executed
