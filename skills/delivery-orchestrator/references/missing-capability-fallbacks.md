# Missing Capability Fallbacks

## Purpose

This reference defines how `delivery-orchestrator` behaves when the ideal next capability does not yet exist as a Createch skill.

## Rule

When a capability is missing:
- keep the missing capability explicit
- assign a named manual fallback
- do not silently absorb the missing capability into another skill

## Current fallbacks

### Workspace bootstrap

No dedicated bootstrap skill exists yet.

Fallback:
- use the project's declared bootstrap strategy
- if none exists, stop and request a human technical decision

Examples:
- `symfony-minimal-starter`
- existing corporate starter
- manual framework bootstrap

## Builder boundary reminder

The absence of a bootstrap skill does not authorize the builder to decide bootstrap strategy.
That decision remains external to the builder and must be visible in workflow state.
