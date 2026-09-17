# Red Flags

This document lists situations that indicate a request is outside the scope of `workflow-ui-ux-advisor` or requires a specific escalation.

When a red flag is detected, do not silently absorb the request.
Either redirect explicitly, or surface the issue and require validation.

---

# Category 1 — Missing or insufficient upstream framing

These red flags indicate that product framing is not ready for UX design.

## RF-101 — No Product Framing Dossier available

The request asks for UX design but no product framing has been done yet.

Response:
- do not design UX
- explain that a Product Framing Dossier is required first
- redirect to `brief-to-product-docs`

## RF-102 — Actors not identified in the framing

The framing exists but the main actors are not yet identified.

Response:
- do not design actor-dependent screens or permissions
- surface the gap
- mark actor-dependent decisions as Needs validation

## RF-103 — Product Quality Gate not yet passed

The framing exists but is not yet validated.

Response:
- note that the UX design may be preliminary
- design conservatively and mark the output as draft
- require re-review after the gate passes

## RF-104 — Blocking arbitration point not yet resolved

The framing has an open D1/D2 arbitration that materially affects the UX flow.

Response:
- design only the UX subset that does not depend on the unresolved decision
- mark the blocked parts as Needs validation
- do not invent the product decision

---

# Category 2 — Request to produce out-of-scope outputs

These red flags indicate the user wants something other than a UX Design Note.

## RF-201 — Request to write .feature content

The user asks to write `.feature` scenarios, Gherkin, or behavioral contracts.

Response:
- do not produce `.feature` content
- explain that `.feature` writing is the role of `sdd-spec-writer`
- produce the UX Design Note that will feed `sdd-spec-writer`

## RF-202 — Request to define backend or API architecture

The user asks to design backend structure, database schema, or API endpoints as part of UX design.

Response:
- do not define backend architecture
- redirect to `module-architecture-advisor` or `saas-solution-architect`

## RF-203 — Request to produce a full visual design system

The user asks for typography, color palette, spacing tokens, or component library design.

Response:
- do not produce visual design systems
- focus only on interaction design, flow, and UX structure
- note that a visual design system is a separate responsibility

## RF-204 — Request to make a product decision

The user asks the skill to decide between two product directions, define the business rule, or choose between two scopes.

Response:
- do not make the product decision silently
- present both options neutrally
- require explicit human arbitration

---

# Category 3 — UX decisions that depend on unresolved product or permission questions

## RF-301 — Permission model unclear for a UX-visible action

A screen or action is visible to some actors but not others, and the permission rule is not yet defined.

Response:
- design the UX conservatively (most restrictive access)
- mark the permission decision as Needs validation
- do not invent the permission model

## RF-302 — Visibility rule unclear (what is shown to which actor)

The framing does not define which data is visible to which actor.

Response:
- design for the most restrictive visible set
- mark visibility rules as Needs validation when they affect the behavioral contract

## RF-303 — Destructive or irreversible action without product validation

The flow includes a destructive action (delete, archive, final submit) that has not been validated in the framing.

Response:
- design a conservative UX (confirmation step, explicit warning)
- mark the action as needing product and UX validation
- do not assume the destructive action is self-evident

---

# Category 4 — Scope drift during UX design

## RF-401 — UX design implies scope expansion

During UX design, the natural flow would add features not in the framing scope.

Examples:
- designing a list page implies adding search, filters, sorting (not in scope)
- designing a create form implies adding bulk import (not in scope)
- designing an archive action implies designing restore behavior (not in scope)

Response:
- keep the UX strictly within the framing scope
- add explicit UX out-of-scope items when drift risk is high
- do not silently add convenience features

## RF-402 — UX choice implies an architecture-level decision

A proposed UX flow would require a specific architecture pattern (e.g., real-time updates, push notifications, offline mode).

Response:
- mark the UX dependency on an architecture decision
- design a fallback conservative UX that works without the advanced pattern
- surface the architecture dependency for `module-architecture-advisor`

---

# Category 5 — Revision-specific red flags

## RF-501 — Revision implies scope expansion

A revision request adds screens, flows, or interactions not in the original UX Design Note scope.

Response:
- do not absorb as editorial cleanup
- surface as an explicit UX scope change
- require validation before expanding

## RF-502 — Revision contradicts a validated product decision

A revision implies changing a UX choice that was grounded in a validated PD-*.

Response:
- preserve the validated UX decision
- require the PD-* to be updated before the UX Design Note can change
- surface the conflict explicitly
