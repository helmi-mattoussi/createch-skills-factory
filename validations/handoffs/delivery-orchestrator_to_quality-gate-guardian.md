# Handoff Validation - delivery-orchestrator -> quality-gate-guardian

## Purpose

This document defines what `quality-gate-guardian` may assume when `delivery-orchestrator` has correctly routed a review unit.

## What quality review may assume

- the delivery unit has reached the review phase
- the intended build unit is explicit
- upstream artifact references are already collected in workflow state
- review ordering is explicit when several reviews are required

## What quality review must not still need to infer

- whether implementation is still premature
- whether it should review the whole project or only one delivery unit
- whether security review should happen before or after quality review in this workflow

## Signs the orchestration handoff is incomplete

- code is still being built
- no delivery unit is named
- review artifacts are missing but the state claims release readiness
