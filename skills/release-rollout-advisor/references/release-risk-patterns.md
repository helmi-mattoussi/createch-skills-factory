# Release Risk Patterns

## Low-risk

Use when:
- no migration is needed
- rollback is straightforward
- no new trust boundary or destructive operation was introduced
- no special sequencing dependency exists

Typical rollout:
- direct release

## Managed-risk

Use when:
- migration exists but is understood and reversible enough
- feature flag is available or a staged enablement is possible
- post-release watch items are clear

Typical rollout:
- staged release or release with watch items

## High-risk

Use when:
- rollback is weak or unclear
- migration is destructive or insufficiently verified
- external dependency timing is unclear
- a critical specialist review is still missing

Typical rollout:
- hold until prerequisites are closed
