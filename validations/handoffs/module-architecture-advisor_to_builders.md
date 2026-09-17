# Handoff Validation — module-architecture-advisor → builders

## Purpose

This document defines what builders (`symfony-apiplatform-builder`, `angular-feature-builder`, `twig-fullstack-builder`) should be able to assume when `module-architecture-advisor` has done its job correctly.

---

## What builders may assume if the Module Architecture Document is complete

- the entities for this module are identified with their key fields
- entity field sources are traceable to validated .feature or ADR
- the state machine is defined with all validated states and transitions
- forbidden state transitions are explicit
- all API operations covered by validated .feature have a defined contract (route, actor, input, output, errors)
- the service layer is structured with named services and single responsibilities
- architecture patterns applied are stated and justified
- module-specific ADR needs are identified
- assumptions are labeled explicitly
- builders can invoke once per module without inventing cross-module ownership

---

## What builders must not still need to invent

- which entities exist and what their core fields are
- the invoice (or equivalent lifecycle entity) state machine design
- what the API routes and operations are for validated behaviors
- which services exist and what each one owns
- which patterns to apply to this module
- whether multiple modules should be merged into one implementation package

---

## What remains for builder judgment

- PHP class, namespace, and method naming conventions
- Doctrine ORM mapping details (annotations / attributes configuration)
- API Platform resource configuration (normalization groups, filters)
- unit and integration test structure
- code-level error handling patterns
- internal method decomposition within services
- query optimization details

---

## Signs the Module Architecture Document is not ready for builders

- no entity model is defined
- no state machine is defined for a lifecycle entity
- API operations are not defined and builders must design them from .feature
- service responsibilities overlap or are unclear
- the document was designed without .feature file input
- a multi-module slice has no explicit build sequence and builders would need to guess module order or ownership

---

## Downstream consumer skills

- `symfony-apiplatform-builder` — primary backend builder
- `angular-feature-builder` — frontend builder (may reference the API contract)
- `twig-fullstack-builder` — fullstack Symfony/Twig builder

---

## Lateral review skills

After builders implement, the following skills should review:
- `quality-gate-guardian` — validates implementation against the architecture
- `security-compliance-guardian` — reviews security-sensitive parts of the architecture
- `performance-scalability-advisor` — reviews if performance risks were identified in the architecture
