# Handoff Validation - module-architecture-advisor -> twig-fullstack-builder

## Purpose

This document defines what `twig-fullstack-builder` may assume when `module-architecture-advisor` has done its job correctly, and what must not remain open for the builder to decide.

## The builder is not an architect

The builder implements.
It does not choose module structure, packaging, or product-safe fallbacks on its own.

If the builder must still choose between architectural patterns, the handoff is incomplete.

## What the builder may assume when the Module Architecture Document is complete

### Implementation contract

- separation is explicit: `Basic` or `Strict`
- write coupling is explicit: `Coupled` or `Decoupled`
- state-machine governance is explicit: `None`, `Simple`, or `Strict`
- reuse scope is explicit: `Project-specific` or `100% Reusable`

### Domain model

- all grounded entities are named with their key fields
- field sources are traceable to `.feature`, `PD-*`, `ADR-*`, or explicit assumptions
- relationships are explicit and directional

### Lifecycle behavior

- validated states are named
- allowed transitions are listed with actor and trigger when a lifecycle exists
- forbidden or unsupported transitions are explicit

### API and interaction contract

- all grounded operations are defined with route, actor, input, output, and errors
- all required screens or server-rendered endpoints implied by the validated `.feature` are visible

### Service structure

- services are named
- each service has one explicit responsibility
- overlaps and non-responsibilities are stated

### Build sequencing

- builders can invoke once per module without inventing cross-module ownership
- if the slice spans multiple modules, the build order is explicit upstream

## What the builder must not still need to decide

The builder must not still need to decide:

- which layers to generate
- whether writes are direct or command-based
- whether lifecycle behavior uses no state machine, enum-enforced transitions, or Symfony Workflow
- whether the module stays app-local or package-ready
- whether a Symfony/Twig workspace must be bootstrapped first
- which entities and fields exist
- what transitions are allowed
- what routes and operations exist
- which service owns which responsibility
- whether multiple module documents should be merged into one implementation package

If any of these are undecided, the handoff must return to `module-architecture-advisor`.

## What remains for builder judgment

The builder may still decide:

- PHP class and method naming
- Doctrine mapping details and indexes
- Symfony Form decomposition
- Twig template decomposition and presentation details
- internal service method structure
- test fixture setup and exact test-file organization

## Signs the handoff is incomplete

| Signal from the builder | Diagnosis | Corrective action |
|---|---|---|
| "I do not know which layers to create" | implementation contract is incomplete | return to `module-architecture-advisor` |
| "Should I use Messenger or direct services?" | write-coupling decision is incomplete | return to `module-architecture-advisor` |
| "I do not know whether this module should be package-ready" | reuse-scope decision is incomplete | return to `module-architecture-advisor` |
| "I do not know the grounded routes or screens" | API or interaction contract is incomplete | return to `module-architecture-advisor` |
| "I need a third shared package to make these two modules work" | cross-module ownership is unclear | stop and escalate upstream |
| "The feature contains a behavior with no entity or service support" | architecture gap | return partial or stop, then escalate upstream |

## Decisions that require escalation

If the builder encounters any of these, it must stop and flag them:

1. a `.feature` scenario with no entity or service support
2. a state transition in `.feature` that is absent from the Module Architecture Document
3. a permission rule in `.feature` that contradicts the architecture packet
4. a behavior that requires another module to own data or UI that the current module does not own
5. a multi-module slice with no explicit build sequence

## Reuse decision - where it lives

| Decision | Skill responsible |
|---|---|
| Should this module be project-specific or targeted for extraction? | `saas-solution-architect` and `module-architecture-advisor` |
| Should the implementation stay app-local or become package-ready? | `module-architecture-advisor` |
| How to implement the prescribed package-ready structure? | `twig-fullstack-builder` |

The builder never decides to create a package-ready structure on its own initiative.
