---
name: performance-scalability-advisor
description: review performance and scalability risk for a delivery unit by reading workflow-state, quality review output, architecture artifacts, and implementation evidence to decide whether query shape, throughput, batch behavior, pagination, caching, and volume assumptions are safe enough for release. use when list-heavy flows, file or batch processing, integrations, async throughput, or other hot paths need governed performance review before release. do not use for general QA, broad architecture redesign, or release sequencing itself.
---

# Purpose

Protect the workflow against late discovery of obvious latency, throughput, or growth risks.

# Core mission

Produce a **Performance and Scalability Review** that:
- identifies meaningful hot-path or data-volume risk
- checks whether the delivery unit has credible guardrails for the intended scope
- separates true performance blockers from watch items and future optimization work
- gives `release-rollout-advisor` a durable view of scale-sensitive watch expectations

# Workflow position

Phase:
- Review, after general quality review and before release planning

Upstream neighbors:
- `quality-gate-guardian`
- `module-architecture-advisor` when the risk originates in structure
- `delivery-orchestrator`

Downstream neighbors:
- `release-rollout-advisor`
- `delivery-orchestrator`

Lateral neighbors:
- `observability-reliability-guardian`

# Trigger conditions

Use this skill when:
- the delivery unit changes query shape, list/search behavior, reporting, or batch behavior
- the unit adds file throughput, async throughput, or data-volume sensitivity
- architecture or review outputs surface meaningful performance risk
- the team needs governed performance review before release

Do not use this skill when:
- the change is structurally simple and low-risk for scale
- the request is general QA or release planning
- the task is broad platform performance redesign

# Required reading behavior

Read in this order:

1. `workflow-state.yaml` when it exists
2. the latest `Quality Gate Review`
3. applicable `Module Architecture Document`
4. applicable `Solution Architecture Map` when dependency shape matters
5. implementation evidence:
   - query behavior
   - list or search behavior
   - batch or file processing behavior
   - caching, pagination, or async notes when they exist

Use:
- `references/source-priority.md`
- `references/performance-risk-patterns.md`

# Operating posture

Use a **risk-focused, non-premature, evidence-aware** posture.

## Risk-focused
- spend attention only where the slice has a plausible hot path or scale-sensitive behavior

## Non-premature
- do not demand heavyweight optimization for a low-scale MVP without evidence

## Evidence-aware
- if obvious risk exists, surface it even when no benchmark exists
- if no benchmark exists but the structure is low-risk, do not invent a blocker

# Review workflow

## Step 1 - Confirm review readiness

Confirm that:
- reviewed scope is explicit
- quality review exists
- there is enough evidence to inspect the risky path

If not, recommend `REWORK`.

## Step 2 - Identify the risk shape

Check whether the reviewed unit includes:
- list or search flows over growing data
- reporting or aggregation behavior
- repeated N+1 or fan-out query shape
- batch processing or file throughput
- synchronous behavior on a path that may grow significantly

## Step 3 - Check current safeguards

Review whether the unit uses, when relevant:
- pagination or bounded list size
- explicit loading strategy
- batching or async handling
- caching where the path clearly justifies it
- bounded processing per request or job

## Step 4 - Judge release risk conservatively

Distinguish:
- acceptable MVP simplicity
- visible managed risk with watch items
- obviously unsafe release shape

Do not convert every possible future scaling concern into a blocker.

## Step 5 - Escalate laterally or upstream when needed

If the review reveals:
- hidden runtime failure visibility issue -> `observability-reliability-guardian`
- security-sensitive throughput risk -> `security-compliance-guardian`
- structural architecture weakness -> route back through the correct architecture artifact

## Step 6 - Produce the Performance and Scalability Review

Return one of:
- `PASS`
- `PASS WITH EXPLICIT FOLLOW-UPS`
- `REWORK`

Use:
- `references/decision-matrix.md`
- `references/review-output-template.md`

## Step 7 - Trigger backward propagation when needed

If the risk exists because the intended scope or architecture was never made explicit:
- surface the missing upstream artifact or decision
- do not hide structural risk behind a vague "optimize later"

Use:
- `references/backward-propagation.md`

# Input contract

Minimum viable inputs:
- latest quality review
- explicit reviewed scope
- enough implementation or architecture evidence for the risky path

Expected maturity:
- build is complete enough for focused performance-risk review

May be missing without blocking the skill:
- formal benchmarks, when structure and evidence are still enough for conservative judgment
- advanced caching or profiling data, when the path is obviously low-risk

Task is premature or invalid when:
- no meaningful evidence exists for the path being judged
- the request is generic platform optimization
- the task is really release sequencing or general QA

# Output contract

Primary output:
- a **Performance and Scalability Review**

The output must include:
- reviewed scope
- risk shape
- key performance findings
- safeguards present or missing
- blockers and watch items
- lateral escalations when needed
- backward propagation path when needed
- final recommendation: `PASS`, `PASS WITH EXPLICIT FOLLOW-UPS`, or `REWORK`

# Next-skill no-invention boundary

If this skill has done its job correctly, `release-rollout-advisor` should no longer need to invent:
- whether obvious scale or latency risks remain hidden
- which performance-related watch items must remain visible after release
- whether the reviewed unit is only MVP-simple or actually unsafe for the intended scope

# Autonomy rules

This skill may decide alone when:
- risk is clearly low, clearly managed, or clearly blocking from the available evidence
- a visible watch item is enough instead of a blocker

This skill must require human validation when:
- release proceeds with known but material scale trade-offs
- the intended production volume is not captured in artifacts and materially changes the judgment
- mitigation depends on infrastructure assumptions not visible in the review packet

# Limits

This skill does not:
- replace the general quality gate
- act as a full benchmarking service
- redesign architecture wholesale
- define release sequencing
- justify speculative optimization work without evidence

# References

Use these references when relevant:
- `references/source-priority.md`
- `references/performance-risk-patterns.md`
- `references/decision-matrix.md`
- `references/backward-propagation.md`
- `references/review-output-template.md`
- `references/final-review-checklist.md`
