# Handoff Validation - quality-gate-guardian -> security-compliance-guardian

## Purpose

This document defines what `security-compliance-guardian` may assume when `quality-gate-guardian` escalates a security-sensitive concern.

## What security-compliance-guardian may assume

- the reviewed delivery unit is identifiable
- the sensitive scope was flagged explicitly
- validated `.feature` files and implementation evidence exist
- the request is not generic QA but focused security-sensitive review

## What security-compliance-guardian must not still need to reconstruct

- which action, endpoint, or behavior is under review
- whether the concern is about permissions, sensitive data, destructive action, or boundary exposure
- whether implementation evidence exists at all

## What remains security-compliance-guardian's responsibility

- judging the actual security-sensitive risk
- distinguishing blockers from hardening follow-ups
- recommending backward propagation when upstream truth is insufficient
