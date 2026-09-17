# Handoff Validation - delivery-orchestrator -> builders

## Purpose

This document defines what builders may assume when `delivery-orchestrator` has correctly routed a build unit.

## What builders may assume

- the build unit is actually in a build-ready phase
- the current module or slice is explicit
- required upstream artifacts are identified
- build order is explicit when several modules exist
- missing bootstrap or workspace preparation is already handled outside the builder path

## What builders must not still need to infer

- whether they are the correct next skill
- which module is active
- whether required UX, `.feature`, or architecture inputs exist
- whether the project is greenfield or already bootstrapped
- whether a multi-module slice should be merged into one generated package

## Remaining builder judgment

- code-level implementation choices that stay inside the prescribed module contract
- framework-level naming and decomposition choices

## Signs the orchestration handoff is incomplete

- no active module is stated
- the builder is invoked while workspace state is still `missing`
- mandatory upstream artifacts are absent
- the orchestration note asks the builder to decide module order
