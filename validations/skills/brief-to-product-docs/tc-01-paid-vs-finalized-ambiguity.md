# Ambiguity Log

## Topic
- Archive eligibility wording for completed invoices

## Why this ambiguity exists
- the brief uses three different expressions for invoice completion:
  - `done invoices`
  - `finalized invoices`
  - possibly `paid invoices`
- no higher-priority source clarifies whether `paid` and `finalized` are equivalent in the current product lifecycle

## Conservative interpretation used
- downstream work may treat `finalized` as the only safe default archive-eligible state
- downstream work must not silently extend eligibility to `paid` invoices

## Impact if left unresolved
- moderate impact on specification quality
- moderate impact on implementation if the codebase models `paid` and `finalized` differently
- low impact on the high-level business objective itself

## Required validation
- confirm the actual lifecycle states in the current invoicing product
- confirm whether `paid` is distinct from `finalized`
- confirm whether archive should apply only to `finalized` or to another validated subset of completed invoices

## Status
- non-blocking for conservative downstream work
- blocking for any broader lifecycle interpretation
