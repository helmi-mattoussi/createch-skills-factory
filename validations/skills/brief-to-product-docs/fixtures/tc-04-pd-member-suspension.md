# PD-117 - Member Suspension MVP

## Decision summary

- Topic: suspend workspace members without deleting their account
- Status: validated

## Stable product decisions

- Only workspace owners may suspend a member.
- Suspension removes the member's active workspace access immediately.
- Suspended members remain visible in a dedicated suspended members view for workspace owners.
- Suspension is not deletion.
- Bulk suspension is out of scope for MVP.
- Restore is out of scope for MVP.
- The action requires explicit confirmation.

## Scope note

This decision applies to the current web application member management area.
