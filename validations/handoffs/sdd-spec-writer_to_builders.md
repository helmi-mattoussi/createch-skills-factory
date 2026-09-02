# Handoff Validation - sdd-spec-writer to builders

## Purpose

This document defines what downstream builders should be able to assume when `sdd-spec-writer` has done its job correctly.

The rule is simple:
- if `sdd-spec-writer` has produced a complete, valid `.feature`, builders must not need to reinvent or rediscover the behavioral contract

## Executed evidence

### Run 1
- Source `.feature`: `validations/skills/sdd-spec-writer/tc-01-member-suspension.feature`
- Source run result: `validations/skills/sdd-spec-writer/tc-01-test-run-result.md`
- Result: builder-facing handoff considered operational on controlled material
- Main strengths:
  - business rules are explicit and reusable
  - permissions are explicit for both suspension and suspended-member visibility
  - confirmation, refusal, and state restriction behavior are covered

### Run 2
- Source `.feature`: `validations/skills/sdd-spec-writer/tc-03-member-suspension-conflict.feature`
- Source run result: `validations/skills/sdd-spec-writer/tc-03-test-run-result.md`
- Result: builder-facing handoff remained operational under `PD` vs `Jira` source conflict
- Main strengths:
  - higher-priority product decision remained authoritative
  - conflicting Jira expansion requests were surfaced without entering the contract
  - scope and permission boundaries stayed explicit for builders

### Run 3
- Source `.feature`: `validations/skills/sdd-spec-writer/tc-08-revised-export.feature`
- Source run result: `validations/skills/sdd-spec-writer/tc-08-test-run-result.md`
- Result: builder-facing handoff remained operational during revise-mode scope-expansion pressure
- Main strengths:
  - the manual export contract stayed stable
  - scheduled export and email delivery were kept out of scope explicitly
  - builders are protected from silently implementing unsupported recurring behavior

### Run 4
- Source `.feature`: `validations/skills/sdd-spec-writer/tc-09-revised-member-suspension.feature`
- Source run result: `validations/skills/sdd-spec-writer/tc-09-test-run-result.md`
- Result: builder-facing handoff remained operational during Jira-driven permission-expansion pressure
- Main strengths:
  - owner-only permission remained explicit
  - the Jira request was surfaced without altering the contract
  - builders remain protected from silently implementing widened suspension rights

### Run 5
- Source `.feature`: `validations/skills/sdd-spec-writer/tc-07-revised-approval-submit.feature`
- Source run result: `validations/skills/sdd-spec-writer/tc-07-test-run-result.md`
- Result: builder-facing handoff remained operational during higher-priority contract correction
- Main strengths:
  - missing permission rules were added explicitly from validated `PD-204`
  - unauthorized behavior is now builder-facing and testable
  - the correction was surfaced as meaningful change rather than hidden cleanup

### Run 6
- Source `.feature`: `validations/skills/sdd-spec-writer/tc-02-expense-approval-partial.feature`
- Source run result: `validations/skills/sdd-spec-writer/tc-02-test-run-result.md`
- Result: builder-facing handoff remained operational on a grounded subset with unresolved permission
- Main strengths:
  - the conservative finance-reviewer path is explicit and implementable
  - manager permission was kept narrow and visible as unresolved
  - builders are protected from inventing a broader approval model

### Run 7
- Source `.feature`: `validations/skills/sdd-spec-writer/tc-05-invoice-archive.feature`
- Source run result: `validations/skills/sdd-spec-writer/tc-05-test-run-result.md`
- Result: builder-facing handoff remained operational under create-mode scope-expansion pressure
- Main strengths:
  - the single-item archive contract stayed explicit and complete
  - batch archive and restore were kept outside the contract
  - builders are protected from silently implementing unsupported archive variants

### Run 8
- Source `.feature`: `validations/skills/sdd-spec-writer/tc-06-revised-invoice-download.feature`
- Source run result: `validations/skills/sdd-spec-writer/tc-06-test-run-result.md`
- Result: builder-facing handoff remained operational after editorial cleanup
- Main strengths:
  - actor and artifact terminology became clearer
  - no behavior or permission drift was introduced
  - builders receive a cleaner contract with unchanged acceptance meaning

## What builders may assume if the `.feature` is complete

- the main business goal is explicit
- the main actor and relevant roles are identified
- the core business rules are stated in the `Business rules` section
- the permission model is explicit for the actions covered
- the nominal behavior is described with a testable scenario
- at least the most important failure and rejection behaviors are described
- the feature scope is bounded with `Out of scope` when drift risk exists
- the feature vocabulary is consistent with the Product Framing Dossier and UX note
- the feature has been aligned with applicable validated sources

## What builders must not invent

- core business rules not stated in the `.feature`
- permission model for covered actions
- state restrictions and allowed state transitions
- important validation conditions and failure behavior
- the main acceptance outcome for nominal scenarios

## What builders are still responsible for

- technical implementation choices such as class design, API schema, and database schema
- framework-level decisions not covered by an `ADR-*`
- internal implementation details not visible in the behavioral contract
- performance optimizations unless specified in a performance requirement
- test harness setup and test execution

## Signs that the `.feature` is not ready and must go back to sdd-spec-writer

- builders cannot understand the expected outcome without inventing it
- builders cannot determine who is allowed to act without inferring
- core business rules are missing and not documented elsewhere
- the feature covers only the happy path
- important edge cases are implied but not stated
- the companion note has unresolved `Needs validation` items that block implementation

## Downstream skills in scope

- `symfony-apiplatform-builder`
- `angular-feature-builder`
- `twig-fullstack-builder`
