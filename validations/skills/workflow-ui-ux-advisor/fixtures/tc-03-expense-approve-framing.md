# Product Framing Dossier

## 1. Header
- Topic: Approve submitted expense reports
- Sources:
  - synthetic validation fixture for `workflow-ui-ux-advisor`
- Status: PASS WITH EXPLICIT FOLLOW-UPS
- Owner: Product review pending

## 2. Business objective
- Objective: Let the organization approve submitted expense reports inside the current web application so reimbursement processing can move forward.
- Expected value:
  - reduce manual follow-up
  - make approval status visible
  - keep expense handling inside the existing workflow

## 3. Problem to solve
- Current pain/problem:
  - expense approvals are not clearly handled in the current workflow
  - teams lack a clear in-app approval step
- Why it matters now:
  - reimbursement is slowed by approval ambiguity

## 4. Scope
### In scope
- approve one submitted expense report
- keep approval inside the existing expense workflow
- show the resulting approved state to the actor

### Out of scope
- rejection flow
- bulk approval
- reimbursement execution

## 5. Actors
- Primary actors:
  - manager
  - finance reviewer
- Secondary actors:
  - employee who submitted the expense report

## 6. Known business rules
- R1: Only submitted expense reports are in scope for approval.
- R2: Bulk approval is out of scope.
- R3: Reimbursement execution is out of scope.

## 7. Assumptions
- A1: None added at framing level.

## 8. Open questions
- Q1: Which actor is actually allowed to approve in MVP: manager, finance reviewer, or both?

## 9. Points to arbitrate / Needs validation
- D1: Approval permission remains unresolved between manager and finance reviewer.

## 10. Risks / vigilance points
- downstream work must not silently choose a broader permission model
- downstream work must not assume both roles can approve without validation

## 11. Source-of-truth and conflicts
- Sources used:
  - synthetic validation fixture
- Conflicts detected:
  - actor boundary for approval is unresolved
- Provisional resolution:
  - keep the approval actor unresolved and visible for downstream caution

## 12. Ambiguity log references
- none

## 13. Readiness for specification
- Ready for spec: Partial
- Stable enough:
  - object and action are clear
  - approval state change is in scope
- Blocking items:
  - actor permission for approval remains unresolved

## 14. Product Quality Gate
- Decision: PASS WITH EXPLICIT FOLLOW-UPS
- Reason:
  - the action and object are stable enough for cautious downstream work
  - actor permission remains unresolved and must stay visible

## 15. Handoff to sdd-spec-writer
### May assume
- one submitted expense report is approved at a time
- approval stays inside the existing expense workflow
- rejection, bulk approval, and reimbursement execution are out of scope

### Must not invent
- whether managers can approve
- whether finance reviewers can approve
- a combined permission model

### Still needs to specify
- none until the approval actor is clarified or conservatively bounded downstream
