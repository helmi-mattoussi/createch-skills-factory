# Ambiguity Log

## Topic
- Meaning of `pause subscription`

## Why this ambiguity exists
- the brief supports at least two plausible business directions
- sales frames pause primarily as a billing relief mechanism
- support frames pause primarily as an access-control mechanism
- no higher-priority source resolves which behavior defines the MVP

## Competing interpretations

### Direction A - Commercial pause
- billing stops or is deferred
- subscription remains recoverable without full cancellation
- access behavior still needs explicit definition

### Direction B - Access freeze
- access stops immediately
- billing behavior still needs explicit definition
- the primary business meaning is operational blocking rather than commercial pause

## Conservative interpretation used
- do not choose between Direction A and Direction B
- preserve only the grounded business objective: avoid cancellation when a temporary stop is needed
- block downstream specification from inventing billing or access semantics

## Impact if left unresolved
- high impact on specification quality
- high impact on billing and access behavior
- high impact on what downstream UX and spec skills would otherwise have to invent

## Required validation
- confirm whether MVP pause is defined first by billing behavior, access behavior, or both
- confirm whether billing changes immediately or only on the next cycle
- confirm whether access stops immediately, at period end, or under another rule

## Status
- blocking for reliable specification
