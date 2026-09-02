# PD-204 - Approval request submission permissions

## Decision summary

- Topic: submission permissions for approval requests
- Status: validated
- Date: 2026-03-27

## Stable product decisions

- Only users allowed to manage an approval request may submit it for review.
- Only approval requests in `draft` state may be submitted for review.
- Submission moves the approval request from `draft` to `pending review`.
- Users without approval-request management rights must be refused.
