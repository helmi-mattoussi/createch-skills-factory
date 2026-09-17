# Handoff Validation - security-compliance-guardian -> release-rollout-advisor

## Purpose

This document defines what `release-rollout-advisor` should be able to assume when `security-compliance-guardian` has done its job correctly.

## What release-rollout-advisor may assume

- security-sensitive scope was explicitly reviewed
- blocking permission or sensitive-data issues were surfaced explicitly
- non-blocking security follow-ups, if any, are visible
- release-relevant safeguards and residual security watch items are visible

## What release-rollout-advisor must not still need to invent

- whether security-sensitive permissions were actually reviewed
- whether blocking security concerns remain hidden
- whether release is being considered with unresolved destructive-action or sensitive-data blockers

## What remains release-rollout-advisor's responsibility

- consolidate security findings into rollout guidance
- decide whether managed-risk release guidance is still needed
- define rollout watch expectations and release communication needs
