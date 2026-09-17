# Red Flags

This document lists situations that indicate a request is outside the scope of `saas-solution-architect` or requires a specific escalation.

---

# Category 1 — Missing or insufficient upstream inputs

## RF-101 — No Product Framing Dossier available

Request asks for solution architecture but no product framing has been done yet.

Response:
- do not produce architecture for an unframed product
- redirect to `brief-to-product-docs`
- explain that framing is required before architecture

## RF-102 — Product Quality Gate not passed

The framing exists but is not yet validated.

Response:
- note that the architecture is preliminary
- design conservatively and mark the output as draft
- require re-review after the gate passes

## RF-103 — Technology stack is unknown

No technology stack has been defined and cannot be reasonably assumed from context.

Response:
- note the gap explicitly
- produce a technology-agnostic module map
- mark ADR needs for stack decisions
- do not make final stack choices unilaterally

## RF-104 — Scope of the product is still a decision point

The framing has open scope arbitrations that materially affect how the solution is structured.

Response:
- design architecture only for the grounded scope
- mark the architectural impact of the unresolved scope as Needs validation
- do not invent the product direction

---

# Category 2 — Requests for out-of-scope outputs

## RF-201 — Request to design module internals

The user asks for class structure, service decomposition, ORM mapping, or detailed API schema for a module.

Response:
- do not design module internals
- redirect to `module-architecture-advisor`
- deliver the module boundary definition and notes for that skill

## RF-202 — Request to write .feature files

The user asks for behavioral specifications within the architecture design.

Response:
- do not write `.feature` content
- redirect to `sdd-spec-writer`

## RF-203 — Request to write implementation code

Response:
- do not write code
- redirect to appropriate builder skill

## RF-204 — Request to make a product decision

The user asks the skill to decide between two product scope directions.

Response:
- do not make the product decision
- present options neutrally if helpful
- require explicit human arbitration with PD-*

---

# Category 3 — Architecture decisions that require explicit validation

## RF-301 — Sensitive cross-cutting technical decision

The architecture requires a decision that is cross-cutting, difficult to reverse, or has security/compliance implications.

Examples:
- data residency or sovereignty strategy
- multi-tenancy isolation model (row-level vs schema vs database)
- authentication strategy (external provider, in-house, hybrid)
- event system architecture (which broker, sync vs async at system level)
- external payment provider integration

Response:
- identify the decision
- present the options conservatively
- mark it as a required ADR
- do not make the final call unilaterally

## RF-302 — Circular dependency between modules

The proposed module structure has a circular dependency.

Response:
- surface the circular dependency explicitly
- do not silently ignore it
- propose at least one way to break the cycle
- mark the resolution as Needs validation if it has product implications

## RF-303 — Module boundary conflict

Two modules seem to overlap in ownership.

Response:
- surface the conflict
- propose a resolution
- do not silently assign ownership to one module
- mark as Needs validation if the resolution has product or UX implications

---

# Category 4 — Scope drift during architecture design

## RF-401 — Architecture implies scope expansion

During mapping, a natural architectural decision would add capabilities not in the product framing.

Response:
- keep the architecture scoped to validated framing
- note the implied expansion as a potential V2+ item
- do not silently add modules for unframed capabilities

## RF-402 — MVP boundary is being inflated

The MVP boundary is growing to include features that are not essential for core value validation.

Response:
- challenge the MVP expansion explicitly
- propose moving non-core items to V2+
- do not quietly accept a bloated MVP

---

# Category 5 — Evolution-mode red flags

## RF-501 — Evolution request adds modules that expand validated scope

A new capability request implies modules that are not supported by any validated framing.

Response:
- design only what is grounded in validated framing
- mark the unsupported modules as requiring upstream framing
- do not absorb as natural architectural extension

## RF-502 — Evolution conflicts with an existing ADR

A proposed architecture evolution would contradict an existing ADR-*.

Response:
- preserve the existing ADR unless it has been explicitly superseded
- surface the conflict
- require a new ADR before changing the architecture in that area
