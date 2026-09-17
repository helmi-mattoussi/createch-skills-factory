# Test Cases - delivery-orchestrator

Each test case defines the current artifact state, the expected routing behavior, and the expected durable state update.

---

## TC-01 - New project starts from a raw brief

Input:
- project README exists
- no workflow-state file yet
- no framing, no `.feature`, no architecture docs

Expected behavior:
- creates initial workflow-state
- routes to `brief-to-product-docs`
- does not suggest build or architecture work

Expected output:
- Workflow Orchestration Decision with `brief-to-product-docs` as next skill

Status: not yet executed

---

## TC-02 - Framing exists but the product gate is still missing

Input:
- product framing dossier exists
- no Product Quality Gate decision recorded

Expected behavior:
- blocks progression to UX or `.feature`
- routes to human Product Quality Gate

Expected output:
- Workflow Orchestration Decision with `human-gate`

Status: not yet executed

---

## TC-03 - Build-ready greenfield slice with missing workspace

Input:
- framing, UX, `.feature`, and module architecture exist
- build readiness is explicit
- stack is Symfony/Twig
- workspace state is `missing`

Expected behavior:
- does not invoke the builder yet
- records manual bootstrap fallback
- keeps build order explicit

Expected output:
- Workflow Orchestration Decision with bootstrap fallback first

Status: not yet executed

---

## TC-04 - Ready existing-project module build

Input:
- workflow-state says `workspace_state: ready`
- stack is Symfony/Twig
- build order exists for one active module

Expected behavior:
- routes to `twig-fullstack-builder`
- passes only the active module as current build unit

Expected output:
- Workflow Orchestration Decision with builder invocation

Status: not yet executed

---

## TC-05 - Implemented slice awaits review

Input:
- build completed
- no quality review yet
- security-sensitive slice

Expected behavior:
- routes first to `quality-gate-guardian`
- records `security-compliance-guardian` as the next later review step

Expected output:
- Workflow Orchestration Decision with ordered review sequence

Status: not yet executed
