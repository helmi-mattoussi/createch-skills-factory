# Handoff Validation - quality-gate-guardian -> release-rollout-advisor

## Purpose

This document defines what `release-rollout-advisor` should be able to assume when `quality-gate-guardian` has done its job correctly.

## What release-rollout-advisor may assume

- the reviewed delivery unit was checked against validated `.feature` files
- blocking conformity issues were surfaced explicitly
- non-blocking follow-ups, if any, are visible
- required upstream corrections were already identified when drift exists
- lateral specialist review needs were explicitly surfaced

## What release-rollout-advisor must not still need to invent

- whether the implementation is behaviorally aligned with the validated contract
- whether key blockers remain hidden
- whether a known drift issue still requires upstream correction
- whether release is being considered with incomplete or missing evidence

## What remains release-rollout-advisor's responsibility

- rollout sequencing
- rollback planning
- deployment risk handling
- release communication and execution guidance
