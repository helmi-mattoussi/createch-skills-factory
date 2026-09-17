---
name: saas-solution-architect
description: transform one or more validated product framing dossiers and .feature files into a solution architecture map that structures the product into modules, capabilities, delivery phases, and dependencies. use when the overall solution structure must be defined before per-module architecture work and implementation. use for initial solution mapping on a new product, a new major capability set, or when the delivery structure needs to be rethought. also use to evolve an existing architecture when significant new capabilities are added. do not use to design detailed module internals, write .feature files, write implementation code, or make product decisions.
---

# Purpose

Transform validated product needs into a **Solution Architecture Map** that structures the product into modules, defines their responsibilities and boundaries, phases delivery across MVP and future iterations, and identifies architecture decisions that must be made before building begins.

This skill exists to prevent teams from building without structure — coding features without understanding how modules relate, what the MVP boundary is, or what technical decisions are still pending.

The skill must stay disciplined:
- do not design detailed module internals (that is `module-architecture-advisor`)
- do not write `.feature` files (that is `sdd-spec-writer`)
- do not write implementation code
- do not make final architecture decisions on sensitive matters without ADR
- do not make product decisions (that requires human arbitration + PD-*)

---

# Core mission

Produce a **Solution Architecture Map** that:
- identifies the main modules of the solution and their responsibilities
- defines the boundaries between modules
- maps the product capabilities to delivery modules
- phases delivery between MVP and future iterations (V2+)
- identifies dependencies between modules and external systems
- surfaces architecture decisions that must be declared as ADR-*
- gives `module-architecture-advisor` a grounded starting point for each module

---

# Operating posture

The skill operates in two modes.

## Mode 1 — Initial architecture

Used when no solution structure exists yet.

The skill:
- reads validated Product Framing Dossier(s) as primary input
- reads validated `.feature` files when available
- reads applicable PD-* and ADR-* for existing constraints
- reads technology stack context when available
- maps capabilities to modules
- defines boundaries, dependencies, and delivery phases
- produces a Solution Architecture Map with ADR needs identified

## Mode 2 — Architecture evolution

Used when a Solution Architecture Map already exists and new capabilities must be integrated.

The skill:
- reads the existing Solution Architecture Map
- reads the new validated Product Framing Dossier(s) or `.feature` files
- assesses the impact on existing modules
- determines whether new modules are needed or existing ones must evolve
- produces an updated Solution Architecture Map with meaningful changes visible

---

# Trigger conditions

## Use this skill when

- one or more Product Framing Dossiers have passed the Product Quality Gate
- the product lacks a solution structure that builders can follow
- a new major capability set is being added to an existing product
- the delivery phasing (MVP vs V2) is not yet defined
- `module-architecture-advisor` would have no grounded starting point for a module

## Do not use this skill when

- the product need has not yet been framed (use `brief-to-product-docs` first)
- the task is per-module detailed architecture (use `module-architecture-advisor`)
- the task is writing `.feature` files (use `sdd-spec-writer`)
- the task is writing application code (use builders)
- the task is a small feature addition that does not require overall restructuring

---

# Required reading behavior

Before designing the architecture, read in this order:

1. validated Product Framing Dossier(s) (primary input)
2. validated `.feature` files (if available — for scoped behavior context)
3. applicable `PD-*` (product decisions that constrain solution structure)
4. applicable `ADR-*` (existing technical decisions that constrain the architecture)
5. technology stack context when provided
6. existing Solution Architecture Map (when in evolution mode)

Use:
- `references/source-priority.md`

---

# Drafting workflow

## Step 0 — Determine mode

If a Solution Architecture Map already exists for the product:
- operate in evolution mode
- apply `references/revision-rules.md` before making any change
- preserve existing validated architecture decisions by default

If no Solution Architecture Map exists, proceed in initial architecture mode from step 1.

---

## Step 1 — Confirm that inputs are architecture-ready

Confirm:
- at least one Product Framing Dossier exists and passed the Product Quality Gate
- the scope is sufficiently clear to identify top-level modules
- known technology stack constraints are available or can be reasonably assumed

If inputs are not ready:
- say so explicitly
- specify what is missing
- do not produce a speculative architecture without grounded product input

Use:
- `references/red-flags.md`

---

## Step 2 — Check source priority and existing constraints

Before designing:
- check applicable PD-* for product constraints that affect solution structure
- check applicable ADR-* for technical constraints (e.g., monorepo vs microservices, chosen framework, database type)
- note existing constraints that must be respected before drawing module boundaries

Use:
- `references/source-priority.md`

---

## Step 3 — Map product capabilities to delivery modules

Identify the main product capabilities from the framing and specifications.

1. Before proposing a module, identify the capabilities and technical foundations already declared in the approved project packet.
2. For each capability:
   - name it using product vocabulary
   - determine which module it belongs to or whether a new module is needed
   - state the module's primary responsibility in one or two sentences
   - mark its status: **[Existing foundation]** or **[To be built]**
   - evaluate its **Reusability Potential**:
     - **[100% Reusable]**: Generic domain (Billing, Auth, Messaging...). Must be architected as an independent, portable package.
     - **[Project-Specific]**: Core business logic unique to this product.

Do not yet define module internals. The goal is to identify modules, their high-level responsibility, and their reusability scope.

Use:
- `references/architecture-output-template.md`

---

## Step 5 — Identify dependencies

For each module:
- list modules it depends on (upstream dependencies)
- list modules that depend on it (downstream dependencies)
- identify external system dependencies (third-party services, auth systems, storage, email...)

Dependency direction matters.
Circular dependencies must be surfaced and resolved or flagged.

---

## Step 6 — Define MVP and V2+ delivery phases

Determine which capabilities and modules are in the MVP.

MVP criteria:
- the MVP should include only what is needed to validate the core product value
- features that are technically required infrastructure must be in MVP even if not user-facing
- nice-to-have features should be moved to V2

For each module or capability:
- state: MVP or V2+
- if V2+, state briefly why it is not needed in MVP

Use:
- `references/decision-matrix.md`

---

## Step 7 — Identify required ADR-* decisions

List all architecture decisions that must be formally made before implementation begins.

For each ADR need:
- state what must be decided
- state why it matters for the architecture
- state the options if they are known
- recommend the conservative or most grounded option when obvious

Do not make final decisions that are sensitive or cross-cutting without validation.

Use:
- `references/ambiguity-policy.md`

---

## Step 8 — Define rough macro delivery order

Propose a phased delivery order for modules and capabilities within MVP.

Consider:
- foundational modules must be built first
- user-facing modules depend on infrastructure/data modules
- shared modules that serve multiple features should be prioritized

Produce a rough delivery sequence, not a Gantt chart.

---

## Step 9 — Stop before module internals and implementation

Do not provide:
- detailed module class structure, service organization, or API schema
- database table design or ORM mapping
- code patterns or framework-level decisions
- implementation plan or sprint planning

These belong to `module-architecture-advisor` and builders.

---

# Input contract

Primary inputs:
- at least one validated Product Framing Dossier (required)
- validated `.feature` files (optional but recommended)
- applicable `PD-*` and `ADR-*` (required when available)
- technology stack context (required when available)
- existing Solution Architecture Map (required in evolution mode)

The skill must not proceed without at least:
- one Product Framing Dossier with explicit scope and main actors
- a technology stack context (framework, language, deployment target)

---

# Output contract

Primary output:
- a **Solution Architecture Map**
- or a partial Solution Architecture Map covering only the stable subset
- or an architecture readiness note explaining why architecture mapping cannot proceed

The output must include when applicable:
- product context (what the solution covers)
- capability map (high-level product capabilities)
- module map (modules and their one-sentence responsibilities)
- module boundary definitions (what each module owns and does not own)
- dependency graph (module-to-module and external dependencies)
- MVP vs V2+ delivery phases
- ADR needs (decisions to formalize before building)
- macro delivery order
- notes for `module-architecture-advisor` per module

The output must:
- use product and domain vocabulary, not framework jargon
- separate validated architecture decisions from assumptions
- surface unresolved architecture decisions explicitly
- give `module-architecture-advisor` a useful and grounded starting point

Use:
- `references/architecture-output-template.md`
- `references/writing-rules.md`

---

# No-invention boundaries

## This skill must not invent

- product capabilities not in the framing
- scope extensions not validated in a Product Framing Dossier
- final decisions on sensitive cross-cutting architecture matters (security, data sovereignty, external integrations)
- specific framework-level patterns or class designs

## module-architecture-advisor must not still need to reconstruct after this skill

- which modules exist and what each one owns
- the module boundary (what a module does not own)
- whether a module is in MVP or V2+
- which other modules it depends on
- which ADR decisions must be made before this module can be designed in detail

If `module-architecture-advisor` would still need to reconstruct these from scratch, the Solution Architecture Map is not complete.

---

# Interaction boundaries with other skills

## Upstream neighbors
- `brief-to-product-docs`: produces the Product Framing Dossier used as primary input
- `sdd-spec-writer`: produces validated `.feature` files used for capability mapping
- `workflow-ui-ux-advisor`: may produce UX structures that inform module boundaries

## Downstream neighbors
- `module-architecture-advisor`: primary consumer — receives a grounded module to detail
- builders: indirect consumer — receive a clear delivery structure

## Lateral neighbor
- `workflow-ui-ux-advisor`: UX complexity sometimes affects module boundaries or API design

## Rules

This skill does not replace product framing.
This skill does not replace per-module architecture.
This skill provides the macro-level structure that connects product scope to implementation organization.

---

# Autonomy rules

The skill may decide alone when:
- a module grouping follows directly from the product capability map
- a dependency direction is obvious from the framing
- a known and established architectural pattern fits the use case without controversy
- the MVP boundary is clearly supported by the product framing

The skill must surface and require validation when:
- an architecture decision is cross-cutting and sensitive (e.g., auth strategy, data isolation, multi-tenancy, event-driven vs request-driven at system level)
- a module boundary is genuinely ambiguous and different choices have significant consequence
- the technology stack is not clearly defined
- an external dependency introduces compliance, security, or vendor-lock concerns
- the MVP boundary is not obvious from the framing

---

# Reference files

Use these references when relevant:
- `references/source-priority.md`
- `references/red-flags.md`
- `references/ambiguity-policy.md`
- `references/decision-matrix.md`
- `references/architecture-output-template.md`
- `references/writing-rules.md`
- `references/examples.md`
- `references/final-review-checklist.md`
- `references/revision-rules.md` (in evolution mode)

---

# Minimal checklist before finalizing

Before delivering the Solution Architecture Map:

- [ ] At least one Product Framing Dossier with passed gate was used as input
- [ ] All major product capabilities are mapped to a module
- [ ] Each module has a clear one-sentence responsibility
- [ ] Module boundaries are explicit (what each module owns and does not own)
- [ ] Dependencies between modules are identified
- [ ] External dependencies are identified
- [ ] MVP vs V2+ boundary is defined
- [ ] Required ADR decisions are listed
- [ ] Macro delivery order is proposed
- [ ] No module internals or class design are included
- [ ] module-architecture-advisor can start without reconstructing module identity
- [ ] Unresolved architecture decisions are marked explicitly

Use:
- `references/final-review-checklist.md`
