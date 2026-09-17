# Handoff Validation - observability-reliability-guardian -> release-rollout-advisor

## Purpose

This document defines what `release-rollout-advisor` should be able to assume when `observability-reliability-guardian` has done its job correctly.

## What release-rollout-advisor may assume

- relevant runtime-operability concerns were reviewed explicitly
- blocking silent-failure or visibility issues were surfaced
- non-blocking watch items are already visible and scoped
- release-facing operational watch expectations are durable

## What release-rollout-advisor must not still need to invent

- whether the delivery unit is operable enough to release safely
- whether silent runtime risks remain hidden
- what post-release monitoring or watch items must remain visible

## What remains release-rollout-advisor's responsibility

- integrate operability findings into rollout strategy
- decide how watch items affect release recommendation
- keep rollout and communication guidance explicit
