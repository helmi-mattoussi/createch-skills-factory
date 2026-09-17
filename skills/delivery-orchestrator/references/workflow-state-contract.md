# Workflow State Contract

## Purpose

This reference defines the durable `workflow-state.yaml` contract used by `delivery-orchestrator`.

The contract must remain stable enough that:
- the orchestrator skill can stay generic
- projects can evolve their state without rewriting the skill itself

## Required fields

```yaml
project: string
stack: string
workspace_mode: greenfield | existing-project
workspace_state: missing | bootstrap-required | ready
current_unit:
  type: product | feature | slice | module-build | delivery-unit
  id: string
current_phase: framing | product-gate | specification | architecture | ready-for-build | in-build | in-review | ready-for-release | released
current_status: draft | blocked | ready | in_progress | awaiting_human_gate | completed
next_action:
  type: invoke-skill | human-gate | manual-fallback
  target: string
  reason: string
artifacts:
  framing: string[]
  ux: string[]
  feature: string[]
  architecture: string[]
  reviews: string[]
build:
  builder: string
  modules_build_order: string[]
  current_module: string
reviews:
  required: string[]
  completed: string[]
blockers:
  - string
fallbacks:
  - string
last_updated: YYYY-MM-DD
```

## Field rules

### `workspace_mode`
- `greenfield`: no application workspace exists yet or the project starts from a starter
- `existing-project`: the application workspace already exists and is being extended

### `workspace_state`
- `missing`: no implementation workspace exists yet
- `bootstrap-required`: the workspace must be prepared before any builder runs
- `ready`: the workspace is available for specialist implementation work

### `current_phase`
Must reflect evidence, not intention.

Examples:
- no validated `.feature` yet -> do not mark `ready-for-build`
- implemented code exists but no gate review happened -> do not mark `ready-for-release`

### `next_action`
Use a single immediate next action.
If later actions are known, keep them in ordered lists under `build` or `reviews`, not as competing next steps.

## Optional fields

```yaml
bootstrap_strategy: string
starter_reference: string
notes:
  - string
human_owners:
  product_gate: string
  build_gate: string
  release_gate: string
```

## Example

```yaml
project: school-dop
stack: symfony-twig
workspace_mode: greenfield
workspace_state: missing
bootstrap_strategy: symfony-minimal-starter
current_unit:
  type: slice
  id: directory-foundation
current_phase: ready-for-build
current_status: ready
next_action:
  type: manual-fallback
  target: workspace-bootstrap
  reason: greenfield Symfony workspace does not exist yet
artifacts:
  framing:
    - docs/product-framing/directory-foundation.md
  ux:
    - docs/ux/directory-foundation-ux.md
  feature:
    - features/directory/directory-foundation.feature
  architecture:
    - docs/architecture/identity-access/module-architecture.md
    - docs/architecture/school-directory/module-architecture.md
  reviews: []
build:
  builder: twig-fullstack-builder
  modules_build_order:
    - IdentityAccess
    - SchoolDirectory
  current_module: IdentityAccess
reviews:
  required:
    - quality-gate-guardian
    - security-compliance-guardian
  completed: []
blockers: []
fallbacks:
  - workspace bootstrap remains manual until a dedicated bootstrap capability exists
last_updated: 2026-03-27
```
