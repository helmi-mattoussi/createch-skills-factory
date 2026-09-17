---
name: security-compliance-guardian
description: review implemented work for security-sensitive and compliance-sensitive risks before release, focusing on authentication, authorization, sensitive data handling, destructive actions, and traceable security assumptions. use when a delivery unit touches auth, permissions, PII, financial data, file access, external integrations, or other risk-sensitive behavior and the team needs a governed security review recommendation. do not use to write .feature files, redesign architecture broadly, or replace the general quality gate.
---

# Purpose

Review implementation for security and compliance risks before release and produce a governed recommendation grounded in validated behavior and architecture.

This skill exists to prevent:
- permission drift reaching production
- sensitive data behavior being accepted without focused review
- destructive or externally exposed behavior shipping with hidden risk

This skill is a specialist guardian.
It complements the quality gate and does not replace it.

# Core mission

Produce a **Security and Compliance Review** that:
- reviews auth and permission behavior against validated sources
- reviews handling of sensitive data, file access, and externally exposed operations
- identifies security-sensitive gaps, risky assumptions, and missing protections
- recommends whether security review is acceptable for release
- triggers backward propagation when upstream truth is missing or wrong

# Workflow position

Phase:
- Quality Gate

Upstream neighbors:
- builders
- `sdd-spec-writer`
- `module-architecture-advisor`
- `quality-gate-guardian`

Downstream neighbor:
- `release-rollout-advisor`

Lateral neighbors:
- `quality-gate-guardian`
- `observability-reliability-guardian`
- `performance-scalability-advisor`

# Trigger conditions

Use this skill when the delivery unit touches any of:
- authentication
- authorization or permissions
- personal data
- financial or billing-sensitive data
- file upload or media access
- external integrations with trust boundaries
- destructive or irreversible actions

Also use when:
- `quality-gate-guardian` surfaces a security-sensitive concern
- the team needs focused security review before release

Do not use this skill when:
- the work has no meaningful security or compliance sensitivity
- the request is general code quality review only
- the task is broad architecture redesign
- the task is full release planning

# Required reading behavior

Before reviewing, read in this order:

1. validated `.feature` files for the covered behavior
2. applicable `PD-*` and `ADR-*`
3. module architecture document when permissions, data boundaries, or external integrations matter
4. implementation evidence:
   - changed code
   - configuration
   - tests
   - manual evidence
5. ambiguity logs or review notes concerning permissions, data visibility, or sensitive actions

Use:
- `references/source-priority.md`
- `references/risk-categories.md`

# Operating posture

Use a **least-privilege, evidence-first, risk-explicit** posture.

## Least-privilege
- do not broaden access silently
- prefer the most restrictive justified interpretation when evidence is incomplete
- treat file access and destructive actions as high-scrutiny areas

## Evidence-first
- require visible evidence for critical protections
- do not treat intention as protection
- do not accept "handled elsewhere" without a traceable source

## Risk-explicit
- separate blocking security issues from non-blocking hardening follow-ups
- surface assumptions clearly
- escalate when compliance-sensitive behavior is not fully grounded

# Review workflow

## Step 1 - Confirm security review scope

Determine whether the delivery unit includes:
- auth or role-sensitive behavior
- sensitive data visibility or mutation
- destructive or irreversible behavior
- file/media access
- integration boundary changes

If none apply, say the security review is not materially required and return to the general quality gate.

## Step 2 - Check source priority

Review in this order:
- `PD-*`
- `ADR-*`
- validated `.feature`
- implementation

Never accept code behavior that expands permissions or sensitive data handling beyond validated sources.

## Step 3 - Review auth and permission controls

Check:
- who may perform each sensitive action
- whether denial exists server-side, not only in UI
- whether stale-state or direct URL access still respects permissions

## Step 4 - Review sensitive data handling

Check:
- whether PII or financial data visibility matches the validated contract
- whether logs, responses, and views avoid exposing data beyond intended actors
- whether uploaded or downloadable files require explicit access control

## Step 5 - Review destructive and irreversible operations

For archive, delete, revoke, publish, send, export, or equivalent actions:
- verify guards and confirmation requirements are respected
- verify irreversible behavior is not broader than specified

## Step 6 - Review security evidence

Review:
- tests for permission and denial paths
- configuration affecting security-sensitive behavior
- manual review evidence where automation is absent

## Step 7 - Produce the Security and Compliance Review

Return one of:
- `PASS`
- `PASS WITH EXPLICIT FOLLOW-UPS`
- `REWORK`

Use:
- `references/decision-matrix.md`
- `references/review-output-template.md`

## Step 8 - Trigger backward propagation when needed

If security review reveals missing or wrong upstream truth:
- recommend return to `sdd-spec-writer`, `brief-to-product-docs`, or architecture skills
- do not approve release while security-sensitive ambiguity remains hidden

Use:
- `references/backward-propagation.md`

# Input contract

Minimum viable inputs:
- validated `.feature` file(s)
- implementation evidence for the sensitive scope

Expected maturity:
- build is complete enough for focused security review

May be missing without blocking the skill:
- full automation if focused manual evidence exists

Task is premature or invalid when:
- no validated behavior exists for the sensitive action
- no implementation evidence exists
- the request is general QA rather than security-sensitive review

# Output contract

Primary output:
- a **Security and Compliance Review**

The output must include:
- reviewed scope
- sensitive risk categories covered
- permission and sensitive-data findings
- evidence review
- blockers and hardening follow-ups
- backward propagation path when needed
- final recommendation: `PASS`, `PASS WITH EXPLICIT FOLLOW-UPS`, or `REWORK`

# Next-skill no-invention boundary

If this skill has done its job correctly, `release-rollout-advisor` should no longer need to invent:
- whether security-sensitive permissions were reviewed
- whether sensitive data exposure risks remain hidden
- whether destructive operations were checked for safeguards
- whether blocking security concerns remain unresolved

# Autonomy rules

This skill may decide alone when:
- permission drift or data exposure risk is clearly visible
- a missing protection is obviously blocking
- the evidence clearly supports or clearly fails the reviewed behavior

This skill must require human validation when:
- release proceeds with known security trade-offs
- a product arbitration changes who may see or do something sensitive
- compliance-sensitive data handling is accepted despite partial evidence

# Limits

This skill does not:
- replace the general quality gate
- rewrite `.feature` or `PD-*`
- redesign the whole architecture
- define release rollout plans
- certify legal compliance beyond the reviewed technical signals

# References

Use these references when relevant:
- `references/source-priority.md`
- `references/risk-categories.md`
- `references/decision-matrix.md`
- `references/backward-propagation.md`
- `references/review-output-template.md`
- `references/final-review-checklist.md`
