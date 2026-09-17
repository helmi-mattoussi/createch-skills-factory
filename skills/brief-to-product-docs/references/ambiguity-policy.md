# Ambiguity Policy

Keep ambiguity visible.

## Separate clearly
- known business rules
- assumptions
- open questions
- points to arbitrate

## Conservative assumptions
Use only when:
- the intent is mostly recoverable
- the assumption narrows risk instead of widening scope
- the assumption does not expand permissions or destructive behavior
- the assumption is labeled explicitly

Treat soft wording such as `probably`, `maybe`, `ideally`, or `would be nice` as uncertainty by default.
Do not convert it into a known rule unless a higher-priority source confirms it.

## Trace when structurally important
Trace ambiguity when it affects:
- permissions
- sensitive data
- lifecycle rules
- state transitions
- first-level scope
- first-level visibility or retrieval after a state-changing action
- cross-source conflicts
- what the next skill would otherwise have to invent
