# Handoff Validation — saas-solution-architect → module-architecture-advisor

## Purpose

This document defines what `module-architecture-advisor` should be able to assume when `saas-solution-architect` has done its job correctly.

---

## What module-architecture-advisor may assume if the Solution Architecture Map is complete

- the module exists and has a clear, one-sentence responsibility
- the module boundary is explicit (what it owns and what it does not own)
- the module's upstream dependencies are identified
- the module's downstream dependents are identified
- the module's external dependencies are identified
- the module's delivery phase (MVP or V2+) is decided
- the module's notes for module-architecture-advisor are present and useful
- the required ADR decisions relevant to the module are identified

---

## What module-architecture-advisor must not still need to reconstruct

- the module's identity and purpose (what it is for)
- the module's scope boundary (what it does not own)
- which other modules it depends on
- whether the module is in MVP or V2+
- which architecture decisions must be made before designing this module

---

## What module-architecture-advisor remains responsible for

- the internal structure of the module (services, entities, API resources)
- the detailed API schema for this module
- the database schema for this module's data
- the internal dependency injection and service design
- framework-specific patterns and implementation choices
- proposing or confirming ADR decisions specific to this module's implementation

---

## Signs the Solution Architecture Map is not ready for module-architecture-advisor

- the module has no clear responsibility
- the "Does not own" boundary is missing
- the dependency map for this module is incomplete
- the module has no notes for module-architecture-advisor
- required ADR decisions that affect this module are not identified

---

## Downstream skills after module-architecture-advisor

- `symfony-apiplatform-builder`
- `angular-feature-builder`
- `twig-fullstack-builder`
