# Test Cases - twig-fullstack-builder

Each test case defines the input type, the expected behavior, and the expected output pattern.

---

## TC-01 - Complete simple architecture handoff

Input:
- Module Architecture Document with `Basic`, `Coupled`, `Simple`, `Project-specific`
- validated `.feature` files for one CRUD-like flow

Expected behavior:
- generates a 3-layer structure only
- uses enum-based state handling
- creates controllers, services, repositories, Twig templates, voters, and tests

Expected output:
- complete generated file list with no architectural invention

Status: executed - `pass with minor gaps`

---

## TC-02 - Complete strict architecture handoff

Input:
- Module Architecture Document with `Strict`, `Decoupled`, `Strict`, `100% Reusable`
- validated `.feature` files for a lifecycle feature

Expected behavior:
- generates a 4-layer structure with handlers and Workflow
- preserves reusable packaging choice
- maps each scenario to generated code and tests

Expected output:
- complete generated file list with bundle structure and Workflow configuration

Status: not yet executed

---

## TC-03 - Incomplete implementation contract

Input:
- Module Architecture Document missing one of the 4 required decisions
- validated `.feature` files exist

Expected behavior:
- stops before generation
- flags the contract gap explicitly
- returns to `module-architecture-advisor`

Expected output:
- no generated code
- explicit stop message

Status: not yet executed

---

## TC-04 - Behavior gap between `.feature` and architecture

Input:
- `.feature` contains a behavior with no service or entity support in the Module Architecture Document

Expected behavior:
- does not invent the missing structure
- either stops or returns only the grounded subset
- flags the gap explicitly

Expected output:
- partial output or stop message with structural gap note

Status: not yet executed

---

## TC-05 - Permission coverage

Input:
- `.feature` includes multiple actor-based permissions

Expected behavior:
- generates voters or equivalent checks for each covered action
- does not broaden access

Expected output:
- generated security layer aligned with `.feature`

Status: executed - `pass`

---

## TC-06 - Multi-module slice packet

Input:
- project packet with two Module Architecture Documents and an explicit build sequence
- validated `.feature` files covering the shared slice
- readiness recommendation making conservative assumptions explicit

Expected behavior:
- splits work into one invocation per module
- does not invent a mega-module or shared package
- keeps shared shell wiring only where upstream artifacts already ground it

Expected output:
- explicit per-module invocation plan
- visible stop conditions for any cross-module invention pressure

Status: executed - `pass`
