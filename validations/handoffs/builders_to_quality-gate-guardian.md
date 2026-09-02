# Handoff Validation - builders -> quality-gate-guardian

## Purpose

This document defines what `quality-gate-guardian` should be able to assume when builders have completed an implementation candidate honestly and completely enough for review.

## What quality-gate-guardian may assume

- changed implementation is available for review
- relevant tests or manual evidence are available, even if incomplete
- the builders worked from validated `.feature` files and applicable architecture documents
- known limitations or TODOs were not hidden intentionally

## What quality-gate-guardian must not still need to reconstruct

- which `.feature` files are in scope
- which implementation areas changed
- whether test evidence exists at all
- whether a known blocker was already observed by builders

## What remains quality-gate-guardian's responsibility

- judging conformity against validated sources
- deciding whether evidence is blocking or non-blocking
- identifying backward propagation needs
- escalating lateral concerns to specialist guardians

## Signs the builder handoff is incomplete

- no clear scope of reviewed changes
- no visible link to the `.feature`
- no evidence for core scenarios
- known deviations are hidden in code but not surfaced
