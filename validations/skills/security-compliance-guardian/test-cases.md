# Test Cases - security-compliance-guardian

Each test case defines the input type, the expected behavior, and the expected output pattern.

---

## TC-01 - Permission review passes

Input:
- validated `.feature` with restricted action
- implementation evidence showing server-side denial and positive path

Expected behavior:
- review confirms permission alignment
- recommendation is `PASS`

Expected output:
- Security and Compliance Review with `PASS`

Status: not yet executed

---

## TC-02 - Authorization drift

Input:
- `.feature` restricts an action to one role
- implementation allows a broader role

Expected behavior:
- review flags authorization drift
- recommendation is `REWORK`

Expected output:
- Security and Compliance Review with blocking authorization issue

Status: not yet executed

---

## TC-03 - Sensitive data exposure risk

Input:
- feature exposes billing or personal data
- implementation leaks more data than required in view or response

Expected behavior:
- review flags exposure risk
- blocks release

Expected output:
- Security and Compliance Review with `REWORK`

Status: not yet executed

---

## TC-04 - Destructive action lacks sufficient safeguard

Input:
- validated `.feature` defines destructive or irreversible action with guard
- implementation omits a required guard or confirmation

Expected behavior:
- review blocks release
- recommends upstream or implementation correction

Expected output:
- Security and Compliance Review with blocking safeguard issue

Status: not yet executed

---

## TC-05 - Non-blocking hardening follow-up

Input:
- sensitive behavior is acceptably protected
- one non-critical hardening improvement remains

Expected behavior:
- review distinguishes blocker from hardening follow-up
- recommendation is `PASS WITH EXPLICIT FOLLOW-UPS`

Expected output:
- Security and Compliance Review with visible follow-up list

Status: not yet executed
