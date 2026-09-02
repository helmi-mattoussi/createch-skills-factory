---
name: twig-fullstack-builder
description: generate Symfony 7 Twig fullstack implementations from a validated Module Architecture Document and validated .feature files. use when a feature is ready for implementation in a Symfony/Twig stack and the builder must follow an explicit architecture contract without inventing behavior or structure. do not use to write .feature files, design module architecture, or make product decisions.
---

# Purpose

Generate Symfony 7 fullstack code from grounded upstream artifacts.

This skill implements:
- the behavioral contract from validated `.feature` files
- the structural contract from `module-architecture-advisor`

This skill does not:
- invent behavior
- choose architecture patterns on its own
- redefine scope
- make product decisions

Current maturity:
- `experimental`
- use only in pilot or supervised runs until validation is completed

---

# Required inputs

Before generating code, read in this order:

1. Module Architecture Document
2. validated `.feature` files for the module
3. applicable `ADR-*`
4. applicable `PD-*`
5. explicit feature-readiness or ambiguity documents only when they are already marked as conservative build assumptions for this module

Primary references:
- `references/symfony-stack.md`
- `references/code-patterns.md`
- `references/twig-turbo-stimulus.md`
- `references/test-patterns.md`

Do not proceed if the Module Architecture Document is missing the builder implementation contract.
Do not proceed if the request would require inventing a multi-module structure from several module documents without an explicit build sequence.

---

# Trigger conditions

Use this skill when:
- the target stack is Symfony + Twig fullstack
- the feature passed readiness checks
- the Module Architecture Document defines the implementation structure
- one module is being implemented per invocation
- a supervised or pilot run is acceptable

Do not use this skill when:
- `.feature` files are missing
- module architecture is incomplete
- the task is API Platform or Angular
- the task is product arbitration, architecture design, or specification writing

---

# Builder contract check

Before writing code, verify that the Module Architecture Document states all four decisions:

1. separation level: `Basic` or `Strict`
2. write coupling: `Coupled` or `Decoupled`
3. state machine approach: `None`, `Simple`, or `Strict`
4. reuse scope: `Project-specific` or `100% Reusable`

If any decision is missing:

```text
Stop.
Flag: Implementation contract incomplete in the Module Architecture Document.
Return to module-architecture-advisor.
```

Do not guess defaults.

---

# Code generation workflow

## Step 0 - Check invocation scope

- implement one module per invocation
- if the slice spans multiple modules, follow the explicit sequence from the project packet and invoke the builder separately for each module
- do not merge multiple Module Architecture Documents into one invented structure
- shared shell or navigation code is allowed only when the owning module or shared boundary is already grounded upstream

## Step 1 - Check workspace readiness

- if `workflow-state.yaml` exists and `workspace_state` is not `ready`, stop
- if `composer.json` or `symfony.lock` is missing, stop
- if the project exists, verify required packages before generating code

If the workspace is not ready:

```text
Stop.
Flag: Symfony/Twig workspace not ready for builder execution.
Return to delivery-orchestrator or the declared bootstrap path.
```

## Step 2 - Translate architecture decisions

Apply the implementation contract exactly:

| Decision | Translation |
|---|---|
| `Basic` separation | Controller -> Service -> Repository |
| `Strict` separation | Domain / Application / Infrastructure / Presentation |
| `Coupled` writes | direct service calls |
| `Decoupled` writes | Command DTOs + handlers + Messenger |
| `None` state machine | no state machine code |
| `Simple` state machine | enum + service-enforced transitions |
| `Strict` state machine | Symfony Workflow |
| `Project-specific` reuse | app-local module namespace |
| `100% Reusable` reuse | bundle or package-ready structure with no project-only hard coupling |

## Step 3 - Parse grounded inputs

Extract from the Module Architecture Document:
- module name
- entities and fields
- state machine
- service responsibilities
- API operations

Extract from `.feature` files:
- scenarios
- actor permissions
- failure cases
- validation rules

Extract from readiness or ambiguity documents only if they are already governed upstream:
- conservative assumptions explicitly accepted for this build
- mandatory stop conditions
- known non-blocking gaps that must remain visible

## Step 4 - Generate structure

Generate only the layers prescribed by the implementation contract.

For strict architecture:
- Domain
- Application
- Infrastructure
- Presentation
- Tests

For basic architecture:
- Entity
- Repository
- Services
- Controller
- Forms and templates
- Security
- Tests

## Step 5 - Generate code

Generate:
- entities and repository contracts
- services or handlers
- controllers
- forms
- Twig templates
- Stimulus controllers when needed
- voters
- tests

When a state machine exists:
- use enum-based transitions for `Simple`
- use Symfony Workflow for `Strict`

## Step 6 - Validate output coverage

Before finalizing, verify:
- every `.feature` scenario maps to code and tests
- every permission rule is enforced
- no entity field was added outside the Module Architecture Document
- no service or pattern was invented outside the implementation contract
- no cross-module dependency was materialized beyond what the module packet already allows

---

# Output format

Return:
1. a generated file tree scoped to the module
2. complete contents for each generated file
3. a scenario-to-file coverage map
4. a permission-to-enforcement map
5. an explicit gap log if any grounded partial output remains

If a grounded partial output is possible but a gap remains:
- generate only the grounded part
- flag the gap explicitly
- do not invent the missing structure

---

# No-invention boundaries

This skill must not invent:
- entity fields not in the Module Architecture Document
- business rules not in validated `.feature` or `PD-*`
- state transitions not in the Module Architecture Document
- permissions not defined in the `.feature`
- architecture patterns not prescribed upstream
- bundle structure when simple namespace is prescribed
- command-handler structure when direct services are prescribed
- cross-module packaging or ownership that is not explicit in the project packet
- conservative assumptions that were never documented upstream
- project bootstrap or starter strategy

When a gap is found:
- stop or return a grounded partial output
- mark the gap explicitly
- return upstream when the gap is structural

---

# Interaction boundaries

Upstream inputs:
- `module-architecture-advisor`
- `sdd-spec-writer`
- `workflow-ui-ux-advisor` when interaction details affect templates
- `delivery-orchestrator` or a project packet that already proves workspace readiness

Downstream reviews:
- `quality-gate-guardian`
- `security-compliance-guardian`
- `performance-scalability-advisor`

This skill implements.
It does not design.

---

# Minimal checklist before finalizing

- [ ] Implementation contract was read and all 4 decisions were applied
- [ ] Invocation scope stayed within one grounded module
- [ ] All entities match the Module Architecture Document exactly
- [ ] State machine implementation matches the prescribed approach
- [ ] Every `.feature` scenario has a generated code path
- [ ] Every `.feature` permission is enforced
- [ ] Tests cover nominal and main error scenarios
- [ ] Twig templates follow the prescribed stack conventions
- [ ] Only documented conservative assumptions were applied
- [ ] No business rule or architecture pattern was invented
- [ ] All structural gaps were flagged explicitly
