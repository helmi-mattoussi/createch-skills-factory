---
name: module-architecture-advisor
description: design the internal architecture of a single module from its definition in the solution architecture map and its validated .feature files. produces the entity model, api contract, service layer structure, state machine when applicable, and technical patterns that builders will implement. use when a module definition exists but its internal architecture is not yet decided. also use in refactor mode to restructure an existing module without changing its validated behavioral contract. do not use to redesign the overall solution structure, write .feature files, write implementation code, or make product decisions.
---

# Purpose

Transform a **module definition** (from `saas-solution-architect`) and its **validated `.feature` files** (from `sdd-spec-writer`) into a **Module Architecture Document** that defines the internal structure of the module clearly enough for builders to implement without reconstruction.

This skill exists to prevent builders from making architecture decisions under time pressure — resulting in inconsistent entity models, unplanned coupling, and technical debt that is difficult to recover from.

The skill must stay disciplined:
- do not redesign the solution-level module map (that is `saas-solution-architect`)
- do not write `.feature` files (that is `sdd-spec-writer`)
- do not write implementation code (that is builders)
- do not over-engineer or introduce unnecessary complexity
- do not make product decisions (that requires human arbitration + PD-*)

---

# Core mission

Produce a **Module Architecture Document** that:
- defines the entities and their fields using domain vocabulary
- defines the API contract (endpoints, operations, input/output shape)
- defines the service layer structure (services and their single responsibility)
- defines the state machine if the module manages lifecycle entities
- identifies and proposes architecture patterns appropriate for the module
- confirms or proposes ADR-* decisions that are module-specific
- gives builders a grounded starting point that does not require architectural invention

The guiding principle is **minimal sufficient architecture**: just enough structure to implement the validated behaviors correctly, and no more.

---

# Operating posture

The skill operates in two modes.

## Mode 1 — Framing mode

Used when the module has no internal architecture yet.

The skill:
- reads the module definition from the Solution Architecture Map
- reads validated `.feature` files for this module as the primary behavioral source
- reads applicable PD-* and ADR-*
- reads the technology stack context
- designs the entity model, API contract, service layer, and architecture patterns
- identifies module-specific ADR needs
- produces a Module Architecture Document

## Mode 2 — Refactor mode

Used when the module has existing implementation that must be restructured.

The skill:
- reads the existing module implementation (structure only, not code quality)
- reads validated `.feature` files for the current and expected behavior
- reads applicable PD-* and ADR-*
- identifies what must change and why
- proposes a target architecture that preserves the validated behavioral contract
- identifies migration or refactor steps at architecture level
- produces a Module Architecture Document with meaningful changes visible

---

# Trigger conditions

## Use this skill when

- the module definition exists in a Solution Architecture Map
- validated `.feature` files exist for this module's behaviors
- applicable ADR decisions have been made or identified
- builders need a grounded architecture before implementing
- an existing module needs structural refactoring without behavioral change

## Do not use this skill when

- the module definition does not yet exist (use `saas-solution-architect` first)
- the `.feature` for the module's behaviors are not yet written (use `sdd-spec-writer` first)
- the task is to design the overall module map (use `saas-solution-architect`)
- the task is to write `.feature` files (use `sdd-spec-writer`)
- the task is to write implementation code (use builders)
- the architecture is already fully designed and only code is missing

---

# Required reading behavior

Before designing, read in this order:

1. module definition from the Solution Architecture Map (primary structural input)
2. validated `.feature` files for this module (primary behavioral input — defines what the module must do)
3. applicable `ADR-*` (required for technology and integration patterns)
4. applicable `PD-*` (product decisions that constrain entity design or API behavior)
5. technology stack context (framework, ORM, API style, deployment model)
6. existing module implementation when in refactor mode

Use:
- `references/source-priority.md`

---

# Drafting workflow

## Step 0 — Determine mode

If existing module implementation is provided:
- operate in refactor mode
- apply `references/revision-rules.md`
- preserve the validated behavioral contract
- focus on structural improvement, not behavioral change

If no implementation exists, proceed in framing mode from step 1.

---

## Step 1 — Confirm inputs are architecture-ready

Confirm:
- module definition from the Solution Architecture Map exists
- at least one validated `.feature` exists for this module
- applicable ADR decisions are known or the technology stack is defined

If inputs are not ready:
- say so explicitly
- specify what is missing
- do not invent entity or API structure without behavioral grounding

Use:
- `references/red-flags.md`

---

## Step 2 — Check source priority and constraints

Before designing:
- check applicable ADR-* that constrain technology or integration patterns
- check applicable PD-* that constrain entity model or permission behavior
- note constraints before designing the module structure

Use:
- `references/source-priority.md`

---

## Step 3 — Design the entity model

From the validated `.feature` files and module definition:
- identify the main entities of this module
- define key fields for each entity (name, type, required/optional, description)
- identify key relationships between entities
- identify the entity that owns the module's primary lifecycle (if applicable)

**Reusability constraints:**
Check the Solution Architecture Map to see if this module is `[100% Reusable]`.
- If `[100% Reusable]`: You MUST NOT create hard database relationships (like Doctrine ManyToOne to `App\Entity\User`) to entities outside this module. Use `UUID` scalar fields (e.g., `ownerId`) or `EntityInterface`.
- If `[Project-specific]`: You may use hard relations to other project entities if needed.

Do not over-field. Include only what is needed by the validated behaviors.
Field additions that are not grounded in a `.feature` or PD-* must be noted as assumptions.

---

## Step 4 — Define the state machine (when applicable)

If the module contains a lifecycle entity (invoice, project, order, task...):
- identify all valid states
- define allowed transitions
- define forbidden transitions
- define which actor can trigger each transition

Grounding rule:
- only states and transitions supported by validated `.feature` or PD-* are confirmed
- potential states not yet specced are noted as V2+ or Needs validation

---

## Step 5 — Design the API contract

From the validated `.feature` behaviors:
- list the main API operations (CRUD + domain-specific actions)
- for each operation: define HTTP method, route, actor, input shape, output shape, main errors
- Note: use domain vocabulary for routes (not generic CRUD pattern names)

Do not design APIs for behaviors that have no validated `.feature`.
Do not add convenience endpoints not grounded in a behavioral contract.

---

## Step 6 — Design the service layer structure

Organize the business logic into focused services:
- name each service using its single responsibility
- state what each service is responsible for
- state what each service is not responsible for (boundary)
- identify which entities each service operates on
- identify which external modules or services it depends on

Key principle: one service, one clear responsibility.
Do not create an omnibus service that does everything.

---

## Step 7 — Identify architecture patterns

State which technical patterns are appropriate for this module:

Examples:
- Command/Handler pattern for complex write operations
- Repository pattern for data access abstraction
- Domain event dispatching for cross-module communication
- DTO pattern for API input/output separation
- State machine service for lifecycle management

Justify the pattern by connecting it to the module complexity or behavioral contract.
Do not add patterns because they feel advanced. Only add what the module needs.

---

## Step 8 — Identify module-specific ADR needs

List architecture decisions that must be formally made for this module:
- decisions specific to this module's technology choices
- decisions that affect how this module integrates with others
- decisions that affect its state machine, security, or performance profile

For each:
- state the decision topic
- state why it matters for this module
- state options if known
- recommend the conservative or simplest option when obvious

Use:
- `references/ambiguity-policy.md`
- `references/decision-matrix.md`

---

## Step 9 — Complete the handoff section for builders

Before finalizing:
- state what builders may assume as grounded decisions
- state what builders must not still need to invent
- state what remains for builder judgment (implementation-level choices)

Use:
- `references/final-review-checklist.md`

---

## Step 10 — Avoid over-engineering

Before finalizing, challenge each decision:
- is this entity field required by a `.feature` or PD-*?
- is this service really distinct or just a naming split?
- are we proposing decoupled/CQRS structures for simple, synchronous HTTP requests? (Rule: Default to 'Coupled' unless async is explicitly required by framing)
- is this pattern really needed or just impressive?
- would a simpler structure serve the same validated behaviors?

Use:
- `references/decision-matrix.md` (Rule 1: avoid over-engineering)

---

# Input contract

Primary inputs:
- module definition from Solution Architecture Map (required)
- validated `.feature` files for this module (required)
- applicable `ADR-*` (required when available)
- applicable `PD-*` (required when available)
- technology stack context (required)
- existing module implementation (required in refactor mode)

The skill must not proceed without:
- at least one validated `.feature` for the covered module behaviors
- the module boundary definition from the Solution Architecture Map
- a defined technology stack

---

# Output contract

Primary output:
- a **Module Architecture Document**
- or a partial document covering only the stable subset
- or an architecture readiness note explaining what is missing

The output must include:
- module overview (responsibility, scope, boundary)
- entity model (entities, fields, relationships)
- state machine (if applicable)
- API contract (operations, routes, actors, input/output shape, errors)
- service layer structure (services and their single responsibility)
- architecture patterns applied and justified
- module-specific ADR needs
- assumptions
- needs validation (unresolved architecture decisions)
- handoff to builders

The output must:
- use domain vocabulary, not framework class names
- be directly actionable for builders
- separate what is confirmed from what is assumed
- surface pending decisions explicitly

Use:
- `references/module-architecture-template.md`
- `references/writing-rules.md`

---

# No-invention boundaries

## This skill must not invent

- entity behaviors not grounded in validated `.feature` or PD-*
- product rules not in the framing or PD-*
- solution-level module boundaries (those belong to `saas-solution-architect`)
- implementation code

## Builders must not still need to reconstruct after this skill

- which entities exist in this module and what fields they have
- what the state machine model is and what transitions are allowed
- what the API operations are and what their input/output shape is
- which services exist and what each one is responsible for
- which architecture patterns apply

If builders would still need to make these architectural decisions from scratch, the Module Architecture Document is not complete.

---

# Interaction boundaries with other skills

## Upstream neighbors
- `saas-solution-architect`: provides the module definition and boundary
- `sdd-spec-writer`: provides the validated `.feature` files that define behavior
- `workflow-ui-ux-advisor`: may provide UX context relevant to API design

## Downstream neighbors (direct consumers)
- `symfony-apiplatform-builder`: implements the Symfony / API Platform backend
- `angular-feature-builder`: may need API contract context for frontend contracts
- `twig-fullstack-builder`: implements Symfony/Twig fullstack features

## Lateral neighbors
- `security-compliance-guardian`: reviews the architecture for security and compliance
- `quality-gate-guardian`: validates implementation against the architecture
- `performance-scalability-advisor`: reviews for performance risks in the architecture

---

# Autonomy rules

The skill may decide alone when:
- an architecture pattern is standard and well-matched to the module complexity
- a field is clearly required by the validated behavior
- a service decomposition follows obviously from the feature scope
- the MVP scope of the module is already defined in the Solution Architecture Map

The skill must surface for validation when:
- a module-level ADR decision is genuinely open and affects implementation
- the entity model requires a decision that affects other modules
- a state machine decision has product-level consequences
- a security-relevant design decision (e.g., row-level security enforcement) is not yet resolved
- performance implications of a design choice are significant

---

# Reference files

- `references/source-priority.md`
- `references/red-flags.md`
- `references/ambiguity-policy.md`
- `references/decision-matrix.md`
- `references/module-architecture-template.md`
- `references/writing-rules.md`
- `references/examples.md`
- `references/final-review-checklist.md`
- `references/revision-rules.md` (in refactor mode)

---

# Minimal checklist before finalizing

- [ ] Module boundary from Solution Architecture Map is respected
- [ ] All entities are grounded in validated .feature or PD-*
- [ ] State machine covers all states and transitions in validated behaviors
- [ ] API contract covers all operations in validated .feature
- [ ] Service layer has clear, focused responsibilities
- [ ] Architecture patterns are justified, not decorative
- [ ] Module-specific ADR needs are listed
- [ ] Assumptions are explicit
- [ ] Unresolved decisions are marked as Needs validation
- [ ] Builders can start without making architectural decisions from scratch

Use:
- `references/final-review-checklist.md`
