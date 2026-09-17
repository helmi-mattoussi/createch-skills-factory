# Handoff Validation - release-rollout-advisor -> delivery-orchestrator

## Purpose

This document defines what `delivery-orchestrator` should be able to assume when `release-rollout-advisor` has done its job correctly.

## What delivery-orchestrator may assume

- release readiness was judged against the available review packet
- rollout pattern, blockers, and watch items are explicit
- missing prerequisites for release remain visible
- the reviewed delivery unit has a durable release recommendation

## What delivery-orchestrator must not still need to invent

- whether the delivery unit is on hold or can move toward release
- which release-oriented next action is justified
- whether rollback, migration, or rollout watch items were considered

## What remains delivery-orchestrator's responsibility

- update `workflow-state.yaml`
- route the project to the next governed step
- keep any remaining manual fallback or human release authority explicit
