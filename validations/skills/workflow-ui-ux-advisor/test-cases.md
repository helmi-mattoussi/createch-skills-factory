# Test Cases - workflow-ui-ux-advisor

Each test case defines the input type, the expected behavior, and the expected output pattern.

---

## Design mode

### TC-01 - Well-scoped flow with explicit actors

Input type:
- validated Product Framing Dossier
- clear scope: one action, one actor, one screen
- no unresolved product decision

Expected behavior:
- skill designs the full UX flow
- user journey covers nominal and failure paths
- screen structure is explicit
- handoff to `sdd-spec-writer` is specific and operational

Expected output:
- complete UX Design Note

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-01-test-run-result.md`

---

### TC-02 - Flow with form logic

Input type:
- validated Product Framing Dossier
- scope includes a form with multiple fields
- validation rules are documented in the framing

Expected behavior:
- skill designs the form with field-by-field description
- validation behavior per field is explicit
- submission behavior (success / validation error / system error) is described

Expected output:
- UX Design Note with a complete form structure section

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-02-test-run-result.md`

---

### TC-03 - Flow with unclear actor permission

Input type:
- validated Product Framing Dossier
- scope is clear
- one action's permission is not yet defined in the framing

Expected behavior:
- skill designs the flow for the most restrictive actor
- marks the permission as Needs validation
- does not silently assign broad access

Expected output:
- UX Design Note + Needs validation for the unclear permission

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-03-test-run-result.md`

---

### TC-04 - Flow where Product Framing Dossier is incomplete

Input type:
- Product Framing Dossier exists but one blocking arbitration point is open
- the open point affects which screens exist

Expected behavior:
- skill designs only the stable UX subset
- marks the blocked part as Needs validation
- does not invent the product answer
- remains useful for the grounded part

Expected output:
- partial UX Design Note + Needs validation for the blocked screens or flows

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-04-test-run-result.md`

---

### TC-05 - Scope-drift pressure during design

Input type:
- Product Framing Dossier covers a single action
- user mentions `it would be nice to also add search and filter`

Expected behavior:
- skill designs only the in-scope action
- adds search and filter to UX out-of-scope
- does not absorb the scope expansion silently

Expected output:
- UX Design Note for the scoped action + explicit UX out-of-scope section

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-05-test-run-result.md`

---

### TC-06 - Flow involving a destructive action

Input type:
- Product Framing Dossier includes a delete or irreversible archive action
- no explicit UX treatment for confirmation is defined in the framing

Expected behavior:
- skill designs a confirmation step conservatively
- notes the confirmation as an assumption
- marks no Needs validation unless the action is itself unclear

Expected output:
- UX Design Note with confirmation UX + explicit assumption note

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-06-test-run-result.md`

---

## Revise mode

### TC-07 - Editorial cleanup only

Input type:
- existing UX Design Note with weak wording
- no product or framing change

Expected behavior:
- skill clarifies wording
- normalizes actor and state terminology
- does not change interaction flow

Expected output:
- revised UX Design Note without meaningful change marker

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-07-test-run-result.md`

---

### TC-08 - Revision from updated PD

Input type:
- existing UX Design Note
- new PD that changes which actor can see a screen

Expected behavior:
- skill updates the screen structure to reflect the new permission
- surfaces the change explicitly
- does not present it as minor editorial update

Expected output:
- revised UX Design Note + meaningful change noted

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-08-test-run-result.md`

---

### TC-09 - Revision request that implies scope expansion

Input type:
- existing UX Design Note covers a single archive action
- revision request asks to also add restore behavior

Expected behavior:
- skill preserves the archive UX
- marks restore as out of scope
- surfaces the expansion explicitly
- does not absorb as a natural addition

Expected output:
- revised UX Design Note unchanged for archive + explicit scope expansion note requiring validation

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-09-test-run-result.md`
