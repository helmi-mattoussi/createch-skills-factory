# Handoff Validation - quality-gate-guardian -> observability-reliability-guardian

## Purpose

This document defines what `observability-reliability-guardian` should be able to assume when `quality-gate-guardian` routes a delivery unit to focused runtime review.

## What observability-reliability-guardian may assume

- the reviewed delivery unit already passed general behavior-conformity review or at least reached a stable review packet
- the relevant implementation evidence was identified
- the operability concern was treated as a lateral specialization, not absorbed into generic QA

## What observability-reliability-guardian must not still need to invent

- what implementation slice is being reviewed
- whether the request is really general QA instead of runtime review
- whether core behavior conformity was already judged at the quality-gate level

## What remains observability-reliability-guardian's responsibility

- judge runtime visibility and failure handling
- identify blockers versus watch items
- recommend release-safe operational follow-ups
