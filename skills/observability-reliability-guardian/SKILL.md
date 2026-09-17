---
name: observability-reliability-guardian
description: review runtime operability and reliability readiness for a delivery unit by reading workflow-state, quality review output, security review output when relevant, architecture notes, and implementation evidence to decide whether logs, health visibility, failure handling, alertability, and operational watch items are sufficient for safe release. use when async work, scheduled jobs, integrations, file processing, or operationally sensitive runtime behavior needs focused review before release. do not use for general QA, security review, broad platform redesign, or release sequencing itself.
---

# Purpose

Protect the workflow against a common blind spot: code can be behaviorally correct and still be unsafe to operate in production.

# Core mission

Produce an **Observability and Reliability Review** that:
- checks whether important runtime behavior is visible and diagnosable
- checks whether important failure paths are surfaced, bounded, or monitored
- separates real operability blockers from non-blocking watch items
- gives `release-rollout-advisor` a durable view of runtime watch expectations

# Workflow position

Phase:
- Review, after general quality review and before release planning

Upstream neighbors:
- `quality-gate-guardian`
- `security-compliance-guardian` when reliability risk touches sensitive boundaries
- `delivery-orchestrator`

Downstream neighbors:
- `release-rollout-advisor`
- `delivery-orchestrator`

Lateral neighbors:
- `performance-scalability-advisor`

# Trigger conditions

Use this skill when:
- the delivery unit adds async or scheduled work
- the delivery unit introduces external integrations, file processing, or hidden background behavior
- quality or security review surfaces operability risk
- the team needs governed runtime-readiness review before release

Do not use this skill when:
- the change is trivial and has no meaningful runtime consequence
- the task is general behavior conformity review
- the task is release sequencing rather than operability review
- the task is broad platform observability redesign

# Required reading behavior

Read in this order:

1. `workflow-state.yaml` when it exists
2. the latest `Quality Gate Review`
3. the latest `Security and Compliance Review` when relevant
4. applicable `Module Architecture Document` when runtime topology matters
5. implementation evidence:
   - logs or log strategy
   - health or failure surfaces
   - async or integration handling
   - operational notes or runbook excerpts when they exist

Use:
- `references/source-priority.md`
- `references/operability-risk-patterns.md`

# Operating posture

Use an **operability-first, conservative, non-absorbing** posture.

## Operability-first
- focus on whether production operators can detect, triage, and react
- treat hidden failures and silent background behavior as serious signals

## Conservative
- prefer visible watch items over optimistic assumptions
- do not assume external systems are reliable unless the reviewed unit handles failure credibly

## Non-absorbing
- do not redesign the whole platform
- escalate security or performance issues rather than absorbing them

# Review workflow

## Step 1 - Confirm review readiness

Confirm that:
- reviewed scope is explicit
- quality review exists
- implementation evidence exists for the runtime behavior being reviewed

If not, recommend `REWORK`.

## Step 2 - Identify the operability risk shape

Check whether the unit includes:
- async or scheduled execution
- external integration or unstable boundary
- file processing or background mutation
- failure paths that users cannot directly see
- behavior that would be hard to diagnose after release without runtime signals

## Step 3 - Check observability coverage

Review whether the unit provides, when relevant:
- meaningful logs or event traces
- actionable failure signals
- operator-visible error states or audit surfaces
- health or readiness signals for non-trivial runtime behavior
- explicit post-release watch items

## Step 4 - Check reliability controls

Review whether the unit provides, when relevant:
- bounded retries or failure handling
- graceful failure behavior
- idempotent or duplicate-safe handling where background retries may occur
- clear manual recovery path when automation fails

Do not require advanced reliability mechanisms if the slice does not justify them.

## Step 5 - Escalate laterally when needed

If the review reveals:
- permission or sensitive-data concern -> `security-compliance-guardian`
- throughput, latency, or scale concern -> `performance-scalability-advisor`
- upstream architecture gap -> route back through the correct architecture artifact

## Step 6 - Produce the Observability and Reliability Review

Return one of:
- `PASS`
- `PASS WITH EXPLICIT FOLLOW-UPS`
- `REWORK`

Use:
- `references/decision-matrix.md`
- `references/review-output-template.md`

## Step 7 - Trigger backward propagation when needed

If a blocking issue exists because runtime behavior was never grounded or architected:
- surface the missing upstream artifact or decision
- do not hide the gap inside an operational workaround

Use:
- `references/backward-propagation.md`

# Input contract

Minimum viable inputs:
- latest quality review
- explicit reviewed scope
- implementation evidence for the relevant runtime behavior

Expected maturity:
- build is complete enough for focused runtime-readiness review

May be missing without blocking the skill:
- security review, if the unit has no meaningful sensitive boundary
- sophisticated dashboards or alerting if simpler grounded visibility is enough for the slice

Task is premature or invalid when:
- no implementation evidence exists
- the request is a general platform observability redesign
- the task is really performance review or release sequencing

# Output contract

Primary output:
- an **Observability and Reliability Review**

The output must include:
- reviewed scope
- runtime risk shape
- observability findings
- reliability findings
- blockers and watch items
- lateral escalations when needed
- backward propagation path when needed
- final recommendation: `PASS`, `PASS WITH EXPLICIT FOLLOW-UPS`, or `REWORK`

# Next-skill no-invention boundary

If this skill has done its job correctly, `release-rollout-advisor` should no longer need to invent:
- whether important runtime behavior is visible enough to operate safely
- whether silent failure risks remain hidden
- what post-release watch items or operational follow-ups must remain visible
- whether the reviewed unit still lacks a credible recovery path for meaningful failures

# Autonomy rules

This skill may decide alone when:
- runtime visibility is clearly sufficient or clearly insufficient
- silent failure risk is obviously blocking
- follow-ups are clearly non-blocking watch items

This skill must require human validation when:
- release proceeds with weak but accepted operational visibility
- production monitoring depends on environment knowledge missing from the artifact packet
- manual recovery or degraded-operation trade-offs are being accepted knowingly

# Limits

This skill does not:
- replace the general quality gate
- redo security review
- certify platform-wide SRE maturity
- redesign architecture wholesale
- define release sequencing

# References

Use these references when relevant:
- `references/source-priority.md`
- `references/operability-risk-patterns.md`
- `references/decision-matrix.md`
- `references/backward-propagation.md`
- `references/review-output-template.md`
- `references/final-review-checklist.md`
