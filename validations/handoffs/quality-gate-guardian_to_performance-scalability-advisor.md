# Handoff Validation - quality-gate-guardian -> performance-scalability-advisor

## Purpose

This document defines what `performance-scalability-advisor` should be able to assume when `quality-gate-guardian` routes a delivery unit to focused performance review.

## What performance-scalability-advisor may assume

- the reviewed delivery unit already passed general behavior-conformity review or reached a stable review packet
- the relevant risky path or evidence was identified
- the performance concern was treated as a lateral specialization, not absorbed into generic QA

## What performance-scalability-advisor must not still need to invent

- what implementation slice is being reviewed
- whether the request is really general QA instead of scale-risk review
- whether core behavior conformity was already judged at the quality-gate level

## What remains performance-scalability-advisor's responsibility

- judge meaningful scale and latency risk
- identify blockers versus watch items
- recommend release-safe performance follow-ups
