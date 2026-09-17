# Test Cases — module-architecture-advisor

---

## Framing mode

### TC-01 — Standard module with clear .feature coverage

Input:
- module definition (responsibility, boundary)
- 3 validated .feature files covering creation, update, and archive
- ADR on auth and data isolation
- Symfony 7 / API Platform stack

Expected behavior:
- entity model with all grounded fields
- state machine with all .feature-covered states
- API contract for all .feature-covered operations
- 3-5 focused services
- patterns justified by module complexity

Expected output:
- complete Module Architecture Document

Status: not yet executed

---

### TC-02 — Module with lifecycle entity (state machine)

Input:
- module definition for a lifecycle entity (project, invoice, order...)
- .feature files covering multiple state transitions
- Not all transitions are specced

Expected behavior:
- confirms only .feature-grounded transitions
- marks unspecced transitions as V2+ or Needs validation
- forbidden transitions are explicit

Expected output:
- Module Architecture Document with complete grounded state machine + Needs validation

Status: not yet executed

---

### TC-03 — Module with missing .feature coverage

Input:
- module definition exists
- only 1 .feature file covering creation
- no coverage for update, archive, or state transitions

Expected behavior:
- designs only what is grounded in the available .feature
- explicitly states what cannot be designed without more .feature coverage
- redirects to sdd-spec-writer for the missing behaviors

Expected output:
- partial Module Architecture Document + .feature gap noted

Status: not yet executed

---

### TC-04 — Over-engineering pressure

Input:
- module is a simple 3-operation CRUD module
- user suggests using event sourcing and CQRS

Expected behavior:
- designs a simple service + entity architecture
- notes that event sourcing and CQRS are not justified at this complexity level
- keeps the architecture minimal

Expected output:
- simple Module Architecture Document with anti-over-engineering note

Status: not yet executed

---

## Refactor mode

### TC-05 — Service layer is too broad

Input:
- existing module with one omnibus service handling creation, state transitions, archiving, number generation
- validated .feature files covering all those behaviors

Expected behavior:
- splits into 4 focused services
- preserves the behavioral contract
- notes the meaningful structural changes

Expected output:
- refactored service layer design + meaningful changes noted

Status: not yet executed

---

### TC-06 — Refactor request would change validated behavior

Input:
- request to change a state machine transition that is in a validated .feature
- the change is justified by "it makes more sense"

Expected behavior:
- refuses to change the state machine without .feature update
- surfaces that this is a behavioral change, not a refactoring
- redirects to sdd-spec-writer first

Expected output:
- no behavioral change + explanation + redirect

Status: not yet executed
