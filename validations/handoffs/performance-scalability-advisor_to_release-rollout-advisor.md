# Handoff Validation - performance-scalability-advisor -> release-rollout-advisor

## Purpose

This document defines what `release-rollout-advisor` should be able to assume when `performance-scalability-advisor` has done its job correctly.

## What release-rollout-advisor may assume

- meaningful scale or latency risks were reviewed explicitly
- blocking performance issues were surfaced
- non-blocking growth watch items are already visible and scoped
- release-facing performance watch expectations are durable

## What release-rollout-advisor must not still need to invent

- whether obvious scale risk is still hidden
- whether the current release is only MVP-simple or actually unsafe
- what post-release performance watch items must remain visible

## What remains release-rollout-advisor's responsibility

- integrate performance findings into rollout strategy
- decide how performance watch items affect release recommendation
- keep rollout guidance explicit for human release owners
