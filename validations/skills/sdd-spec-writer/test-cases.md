# Test Cases - sdd-spec-writer

Each test case defines the input type, the expected behavior, and the expected output pattern.

---

## Create mode

### TC-01 - Well-scoped request with explicit permissions

Input type:
- validated Product Framing Dossier with clear objective, actors, and scope
- explicit known business rules
- no source conflict

Expected behavior:
- skill produces a full `.feature` without companion note
- all business rules are in the `Business rules` section
- permissions are explicit
- at least nominal + failure + permission scenarios are covered

Expected output:
- `.feature` only

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-01-test-run-result.md`

---

### TC-02 - Partial product framing with one unresolved permission

Input type:
- framing is mostly complete
- one permission is unclear between two roles

Expected behavior:
- skill produces the `.feature` for the grounded part
- marks `Needs validation` for the unclear permission
- does not broaden access silently

Expected output:
- `.feature` + companion note with `Needs validation`

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-02-test-run-result.md`

---

### TC-03 - Source conflict between Jira and a validated PD

Input type:
- validated PD says one behavior
- Jira ticket implies a different behavior
- no updated PD supporting the Jira version

Expected behavior:
- skill follows the PD (higher-priority source)
- surfaces the conflict explicitly
- does not silently merge contradictory meanings

Expected output:
- `.feature` aligned with PD + companion note flagging the conflict

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-03-test-run-result.md`

---

### TC-04 - Request that is still in discovery, not spec-ready

Input type:
- vague goal
- multiple product directions still plausible
- no validated framing available

Expected behavior:
- skill does not produce a full `.feature`
- explains that the request is not spec-ready
- redirects conceptually to upstream product framing

Expected output:
- no contract or very partial safe subset + clear explanation of missing framing

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-04-test-run-result.md`

---

### TC-05 - Scope-drift pressure during create

Input type:
- framing is for a single-item archive action
- user asks to also include batch archive and restore

Expected behavior:
- batch archive and restore are kept out of scope
- `Out of scope` section is explicit
- feature stays focused on the validated single-item contract

Expected output:
- `.feature` with explicit `Out of scope` + companion note if user pressed for expansion

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-05-test-run-result.md`

---

## Revise mode

### TC-06 - Editorial cleanup without contract change

Input type:
- existing `.feature` is too vague in wording only
- no higher-priority source suggests a product change

Expected behavior:
- clarifies wording
- normalizes terminology
- does not change acceptance meaning
- does not widen scope

Expected output:
- revised `.feature` with no meaningful change note needed

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-06-test-run-result.md`

---

### TC-07 - Contract correction from higher-priority source

Input type:
- existing `.feature` is missing a permission rule present in a validated PD
- the PD was published after the `.feature`

Expected behavior:
- adds the missing rule from the PD
- surfaces the change explicitly
- does not present the correction as editorial cleanup

Expected output:
- revised `.feature` + `Meaningful changes` note

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-07-test-run-result.md`

---

### TC-08 - Revision request that implies scope expansion

Input type:
- existing `.feature` covers a manual export
- user asks to add scheduled email delivery in the same revision

Expected behavior:
- manual export contract is preserved and strengthened
- scheduled export and email delivery are kept out of scope
- scope expansion is identified and surfaced, not silently absorbed

Expected output:
- revised `.feature` + companion note with `Needs validation` for the expansion

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-08-test-run-result.md`

---

### TC-09 - Jira drift normalization pressure

Input type:
- Jira ticket implies permission expansion
- no validated source supports the expansion

Expected behavior:
- skill preserves the validated contract
- surfaces the ticket request as a `Needs validation` point
- does not normalize drift

Expected output:
- revised `.feature` unchanged on permissions + companion note

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-09-test-run-result.md`
