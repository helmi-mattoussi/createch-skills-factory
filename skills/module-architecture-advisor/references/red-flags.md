# Red Flags

This document lists situations that indicate a request is outside the scope of `module-architecture-advisor` or requires escalation.

---

# Category 1 — Missing or insufficient inputs

## RF-101 — No module definition available

The request asks for module architecture but no Solution Architecture Map defines the module.

Response:
- do not design without a module definition
- redirect to `saas-solution-architect`

## RF-102 — No validated .feature files for this module

The module is defined but no `.feature` files exist for its behaviors.

Response:
- note that the entity model and API contract cannot be grounded without `.feature`
- redirect to `sdd-spec-writer`
- do not invent entity fields or API operations

## RF-103 — Technology stack is not defined

The stack is unknown and cannot be reasonably assumed.

Response:
- note the gap
- design a technology-agnostic architecture (entities and services without framework specifics)
- mark ADR need for the stack decision

## RF-104 — Required ADR is completely missing

A cross-cutting architecture decision that blocks module design is not yet decided.

Response:
- note what is blocked
- design around the pending decision where possible
- mark as ADR need and do not proceed on the blocked part

---

# Category 2 — Requests for out-of-scope outputs

## RF-201 — Request to write .feature content

Response:
- redirect to `sdd-spec-writer`
- do not generate Gherkin scenarios

## RF-202 — Request to redesign the module map

The user asks to change which modules exist or what their boundaries are.

Response:
- redirect to `saas-solution-architect`
- do not redesign the solution-level module structure

## RF-203 — Request to write implementation code

Response:
- redirect to the appropriate builder skill

## RF-204 — Request to make a product decision

Response:
- do not make the product decision
- mark as Needs validation + PD-* process

---

# Category 3 — Over-engineering risks

## RF-301 — Microservice decomposition pressure

The request implies splitting into microservices without any ADR or product justification.

Response:
- design a monolith-compatible module architecture
- note the microservice consideration as a future ADR topic if relevant
- do not adopt microservices by default

## RF-302 — Event sourcing or CQRS pressure without need

The module's complexity does not justify event sourcing or full CQRS.

Response:
- apply the simpler architecture that satisfies the validated behaviors
- note the more complex pattern as a future consideration if the domain grows
- do not add patterns for sophistication alone

## RF-303 — Service layer artificially split into too many services

The module would have 10+ services for a module with 5 validated behaviors.

Response:
- consolidate into focused services
- each service must have a real single responsibility
- naming clarity is not sufficient justification for splitting

---

# Category 4 — Security and permission design

## RF-401 — Permission enforcement strategy is unclear

The `.feature` specifies who can do what, but where and how to enforce the permission is not yet decided.

Response:
- design the conservative restrictive default
- mark the enforcement strategy as ADR need

## RF-402 — Sensitive data access pattern is unresolved

A field or entity contains sensitive data (PII, financial, health) and the access control pattern is not defined.

Response:
- use the most restrictive design
- mark as ADR need and escalate to `security-compliance-guardian`

---

# Category 5 — Refactor-specific red flags

## RF-501 — Refactor would change validated behavioral contract

The proposed refactoring would alter what the module does, not just how.

Response:
- do not change behavior during refactoring
- scope refactoring to structural changes only
- any behavioral change requires `.feature` update first

## RF-502 — Refactor contradicts an existing ADR

The proposed new structure conflicts with a decided ADR.

Response:
- preserve the ADR
- surface the conflict
- require a new ADR before changing the architecture in that area

## RF-503 — Existing code has no .feature coverage

The code does behaviors that no `.feature` describes.

Response:
- note the coverage gap
- do not architect around undocumented behaviors
- redirect to `sdd-spec-writer` to add `.feature` coverage before refactoring those behaviors
