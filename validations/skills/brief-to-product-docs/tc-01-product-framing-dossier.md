# Product Framing Dossier

## 1. Header
- Topic: Invoice archive for the existing web invoicing module
- Sources:
  - `validations/skills/brief-to-product-docs/fixtures/tc-01-messy-invoice-archive-brief.md`
- Status: PASS WITH EXPLICIT FOLLOW-UPS
- Owner: Product review pending

## 2. Business objective
- Objective: Allow the billing team to remove completed invoices from the default active list without deleting invoice data.
- Expected value:
  - reduce noise in the active invoice list
  - reduce accidental opening of invoices that should no longer be handled as active
  - offer a safer alternative than deletion

## 3. Problem to solve
- Current pain/problem:
  - completed invoices remain mixed with active invoices
  - billing users keep opening invoices that are no longer operationally active
  - the team lacks a safe visibility-management action for completed invoices
- Why it matters now:
  - the issue already creates recurring friction for the billing team
  - deletion is explicitly not wanted for the first version

## 4. Scope
### In scope
- archive an invoice in the existing invoicing module
- remove archived invoices from the default active invoice list
- keep archived invoices accessible through a separate archive access path
- restrict archive capability to billing administrators
- define archive only for invoices that are considered completed under the validated lifecycle rule

### Out of scope
- permanent deletion
- restore
- bulk archive
- archive analytics
- mobile-specific behavior

## 5. Actors
- Primary actors:
  - billing administrator
- Secondary actors:
  - standard billing user
  - finance lead as business stakeholder

## 6. Known business rules
- R1: This first version must not delete invoice data.
- R2: Only billing administrators may archive invoices.
- R3: Standard billing users must not archive invoices.
- R4: Archived invoices must not remain in the default active invoice list.
- R5: Archived invoices must remain accessible somewhere outside the default active list.

## 7. Assumptions
- A1: The current role model already supports a distinction equivalent to billing administrator versus standard billing user.
- A2: Archive should include an explicit confirmation step because the action changes invoice visibility and the brief raises accidental click risk.
- A3: The archive capability stays inside the existing web invoicing module and does not require a mobile flow.

## 8. Open questions
- Q1: What is the exact retrieval pattern for archived invoices in MVP: dedicated archive view, filter, or another separate access path?
- Q2: Does the archive retrieval path need search in MVP or can simple visibility be sufficient for the first version?

## 9. Points to arbitrate / Needs validation
- D1: Confirm the exact lifecycle rule for archive eligibility. The brief mentions `done invoices`, `finalized invoices`, and possibly `paid invoices`, but only `finalized` is specific enough to use as the conservative default.
- D2: Confirm whether the confirmation step is a validated product rule or a conservative MVP assumption.

## 10. Risks / vigilance points
- archive must not drift into deletion behavior
- downstream work must not silently broaden archive eligibility from `finalized` to `paid`
- the separate archive access path must not expose archive capability to standard billing users

## 11. Source-of-truth and conflicts
- Sources used:
  - raw client and workshop brief
  - stakeholder note from the finance lead inside the brief
- Conflicts detected:
  - lifecycle terminology is inconsistent across the brief: `done`, `finalized`, and possibly `paid`
- Provisional resolution:
  - use `finalized` as the conservative default for downstream work
  - keep `paid` versus `finalized` open until product validation confirms the real lifecycle meaning

## 12. Ambiguity log references
- `validations/skills/brief-to-product-docs/tc-01-paid-vs-finalized-ambiguity.md`

## 13. Readiness for specification
- Ready for spec: Partial
- Stable enough:
  - business objective is clear
  - archive versus delete boundary is clear
  - permission intent is clear at first level
  - core first-version scope is bounded
- Blocking items:
  - `sdd-spec-writer` must not invent whether `paid` is archive-eligible
  - `sdd-spec-writer` must keep the archive access path generic unless product clarifies the exact retrieval pattern

## 14. Product Quality Gate
- Decision: PASS WITH EXPLICIT FOLLOW-UPS
- Reason:
  - the business objective and first-level scope are stable enough for controlled downstream work
  - the unresolved points are visible and bounded
  - no strategic product direction conflict remains
- Follow-ups:
  - validate `paid` versus `finalized` before formalizing archive eligibility beyond the conservative default
  - validate whether confirmation is a firm business rule or an MVP safety assumption
  - validate the exact archive retrieval path for MVP

## 15. Handoff to sdd-spec-writer
### May assume
- archive is a visibility-management action, not deletion
- only billing administrators may archive invoices
- standard billing users must not archive invoices
- archived invoices leave the default active list
- archived invoices remain accessible through a separate archive access path
- the conservative eligibility default is `finalized` invoices only until product says otherwise

### Must not invent
- deletion behavior
- restore behavior
- bulk archive behavior
- archive eligibility for `paid` invoices
- a specific archive retrieval UX pattern unless it is validated upstream
- broader access for standard billing users

### Still needs to specify
- scenario structure and acceptance wording
- refusal cases and permission cases
- how the separate archive access path behaves from a user perspective
- whether the conservative confirmation assumption becomes explicit product behavior
