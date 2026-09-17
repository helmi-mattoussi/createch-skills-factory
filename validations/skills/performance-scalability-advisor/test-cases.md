# Test Cases - performance-scalability-advisor

Each test case defines a scale-sensitive review packet, the expected risk judgment, and the expected recommendation.

---

## TC-01 - Bounded list flow with acceptable safeguards

Input:
- quality review `PASS`
- list flow exists
- pagination and bounded query shape are explicit

Expected behavior:
- accepts the release shape
- final recommendation is `PASS`

Status: not yet executed

---

## TC-02 - Query-heavy path with explicit watch item only

Input:
- quality review `PASS`
- current volume is low
- one optimization follow-up remains visible

Expected behavior:
- keeps the release allowed
- final recommendation is `PASS WITH EXPLICIT FOLLOW-UPS`

Status: not yet executed

---

## TC-03 - Unbounded reporting path on intended MVP scope

Input:
- quality review passed
- reporting path is obviously unbounded for the intended release scope

Expected behavior:
- blocks release-readiness at the performance level
- final recommendation is `REWORK`

Status: not yet executed

---

## TC-04 - Performance issue is really an architecture issue

Input:
- quality review passed
- risky path exists because processing ownership is structurally unclear

Expected behavior:
- recommends backward propagation
- final recommendation is conservative

Status: not yet executed
