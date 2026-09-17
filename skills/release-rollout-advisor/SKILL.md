---
name: release-rollout-advisor
description: prepare safe rollout guidance for a delivery unit that already passed implementation review by reading quality-gate outputs, security review outputs when applicable, workflow-state, and deployment constraints to decide release readiness, rollout sequencing, rollback expectations, and release communication needs. use when a feature or slice is moving from review to release, when Jira is approaching `Ready for Release`, or when the team needs a governed go/no-go rollout recommendation. do not use to review behavior conformity, redo security review, bootstrap environments, or perform the deployment itself.
---

# Purpose

Prepare safe rollout guidance for a delivery unit that is leaving review and approaching release.

This skill exists to prevent three failure modes:
- technically correct increments ship without rollout discipline
- release decisions ignore migration, rollback, or feature-flag risk
- release readiness lives in informal chat instead of a durable recommendation

# Core mission

Produce a **Release Rollout Recommendation** that:
- confirms whether the delivery unit is actually ready to move from review to release
- identifies rollout risk level and the appropriate rollout pattern
- makes migration, rollback, flag, and communication expectations explicit
- separates true blockers from monitored follow-ups
- provides a release-ready packet for human release authority

# Workflow position

Phase:
- Release

Upstream neighbors:
- `quality-gate-guardian`
- `security-compliance-guardian` when relevant
- `delivery-orchestrator`

Downstream neighbors:
- human release owner
- `delivery-orchestrator`

Lateral neighbors:
- `observability-reliability-guardian`
- `performance-scalability-advisor`

# Trigger conditions

Use this skill when:
- a delivery unit passed quality review and is approaching release
- Jira or workflow-state is moving toward `Ready for Release`
- the team needs a governed rollout recommendation before deployment
- the release includes migrations, flags, sequencing, or rollback concerns

Do not use this skill when:
- implementation is still in build or review
- quality or security review is still missing for a sensitive unit
- the task is to validate behavior correctness or permission correctness
- the task is to execute the release itself

# Required reading behavior

Before advising release, read in this order:

1. `workflow-state.yaml` when it exists
2. the latest `Quality Gate Review`
3. the latest `Security and Compliance Review` when the unit is security-sensitive
4. the latest `Observability and Reliability Review` when runtime operability risk is relevant
5. the latest `Performance and Scalability Review` when throughput or data-volume risk is relevant
6. validated `.feature` summary or reviewed scope note
7. deployment-relevant notes:
   - migration needs
   - feature-flag notes
   - rollback constraints
   - release sequencing notes

Use:
- `references/source-priority.md`
- `references/release-risk-patterns.md`

# Operating posture

Use a **release-safe, blocker-explicit, execution-aware** posture.

## Release-safe
- do not assume rollout is safe just because code passed review
- treat migrations, destructive changes, and external dependencies as rollout multipliers

## Blocker-explicit
- separate `hold` conditions from monitored follow-ups
- do not hide missing rollback or flag strategy behind vague optimism

## Execution-aware
- recommend only rollout patterns that fit the actual delivery unit
- keep the recommendation usable by a human release owner

# Review workflow

## Step 1 - Confirm release-input readiness

Confirm that:
- quality review exists
- security review exists when the unit is security-sensitive
- observability review exists when runtime operability was explicitly escalated
- performance review exists when meaningful scale or latency risk was explicitly escalated
- the current unit is explicit
- the current workflow state is at least `in-review` or equivalent

If these are false, stop and recommend `HOLD`.

## Step 2 - Check release blockers from upstream reviews

Do not overrule upstream reviews.

If upstream reviews still show blocking items:
- keep the unit on hold
- state that release planning cannot proceed yet

## Step 3 - Assess rollout risk shape

Assess whether the unit includes:
- schema or data migration
- configuration or environment dependency
- feature flag need
- irreversible or hard-to-rollback behavior
- integration dependency or sequencing dependency

Classify the release shape conservatively:
- `low-risk`
- `managed-risk`
- `high-risk`

## Step 4 - Choose rollout pattern

Recommend the simplest grounded rollout pattern:
- direct release
- release behind feature flag
- staged rollout with explicit watch items
- hold pending missing prerequisite

Do not invent sophisticated rollout mechanics if the actual environment does not support them.

## Step 5 - Define rollback and watch expectations

State:
- whether rollback is straightforward, constrained, or not credible
- what must be watched after release
- whether a migration must be tested or sequenced specially

If rollback is not credible and no mitigation exists, treat it as a blocker or a managed-risk watch item depending on severity.

## Step 6 - Produce the Release Rollout Recommendation

Return one of:
- `READY FOR RELEASE`
- `READY FOR RELEASE WITH WATCH ITEMS`
- `HOLD`

Use:
- `references/decision-matrix.md`
- `references/review-output-template.md`

## Step 7 - Update release-facing workflow state when relevant

If `workflow-state.yaml` exists:
- update the current phase or next action only when the release recommendation justifies it
- do not mark `Released` unless deployment actually happened

# Input contract

Minimum viable inputs:
- latest quality gate output
- delivery-unit identification

Expected maturity:
- implementation review is complete enough that release is a real next-step question

May be missing without blocking the skill:
- security review, if the delivery unit is not security-sensitive
- observability review, if the unit has no meaningful operability risk
- performance review, if the unit has no meaningful scale or latency risk
- elaborate release notes, if rollout guidance can still be produced

Task is premature or invalid when:
- the unit is still being built
- quality review is missing
- release planning would need to guess what was reviewed

# Output contract

Primary output:
- a **Release Rollout Recommendation**

The output must include:
- reviewed delivery unit
- upstream reviews consulted
- rollout risk classification
- recommended rollout pattern
- migration, flag, rollback, and watch-item notes
- final recommendation: `READY FOR RELEASE`, `READY FOR RELEASE WITH WATCH ITEMS`, or `HOLD`

# Next-skill no-invention boundary

If this skill has done its job correctly, the human release owner or `delivery-orchestrator` should no longer need to invent:
- whether release is blocked by unresolved review findings
- what rollout pattern is recommended
- whether rollback expectations were considered
- which watch items or follow-ups must remain visible after release

# Autonomy rules

This skill may decide alone when:
- upstream review status clearly blocks or allows release planning
- rollout risk is clear from the artifact packet
- a simple direct release or hold recommendation is obvious

This skill must require human validation when:
- release proceeds with managed risk
- rollback is weak but the team may still choose to ship
- deployment sequencing depends on environment knowledge not captured in artifacts

# Limits

This skill does not:
- redo behavior or security review
- approve product arbitrations
- execute deployments
- guarantee that an environment is healthy
- replace human release authority

# References

Use these references when relevant:
- `references/source-priority.md`
- `references/release-risk-patterns.md`
- `references/decision-matrix.md`
- `references/review-output-template.md`
- `references/final-checklist.md`
