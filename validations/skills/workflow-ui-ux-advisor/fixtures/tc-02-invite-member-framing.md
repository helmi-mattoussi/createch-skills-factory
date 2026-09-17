# Product Framing Dossier

## 1. Header
- Topic: Invite one member to a workspace
- Sources:
  - synthetic validation fixture for `workflow-ui-ux-advisor`
- Status: PASS
- Owner: Product review pending

## 2. Business objective
- Objective: Let workspace administrators invite one new member to the workspace from the web application.
- Expected value:
  - reduce manual onboarding steps
  - keep member invitation inside the existing workspace management flow

## 3. Problem to solve
- Current pain/problem:
  - inviting a new member is not handled clearly inside the current workspace flow
  - administrators need a direct in-product action
- Why it matters now:
  - onboarding friction slows workspace setup

## 4. Scope
### In scope
- invite one new workspace member
- collect the invited email and role
- allow an optional note for the invitation
- confirm invitation submission outcome in the web application

### Out of scope
- bulk invite
- editing a sent invitation
- resending an invitation
- advanced permission configuration

## 5. Actors
- Primary actors:
  - workspace administrator
- Secondary actors:
  - invited user receiving the invitation

## 6. Known business rules
- R1: Only workspace administrators may invite a member.
- R2: One invitation is created at a time.
- R3: `Email` is required and must be a valid email format.
- R4: `Role` is required and must be selected from the workspace roles already available in the product.
- R5: `Note` is optional.
- R6: An invitation cannot be created for an email that already belongs to an active workspace member.
- R7: An invitation cannot be created for an email that already has a pending invitation in the same workspace.

## 7. Assumptions
- A1: None.

## 8. Open questions
- Q1: None blocking at framing level.

## 9. Points to arbitrate / Needs validation
- D1: None.

## 10. Risks / vigilance points
- downstream work must not invent extra form fields
- downstream work must not widen role configuration beyond the validated workspace roles

## 11. Source-of-truth and conflicts
- Sources used:
  - synthetic validation fixture
- Conflicts detected:
  - none
- Provisional resolution:
  - none needed

## 12. Ambiguity log references
- none

## 13. Readiness for specification
- Ready for spec: Yes
- Stable enough:
  - actor boundary is clear
  - form fields and validation rules are explicit at framing level
- Blocking items:
  - none

## 14. Product Quality Gate
- Decision: PASS
- Reason:
  - the business goal, actor boundary, and form rules are stable enough for downstream UX design

## 15. Handoff to sdd-spec-writer
### May assume
- the flow is about inviting one workspace member
- only workspace administrators may invite
- `Email` and `Role` are required
- `Note` is optional
- duplicate active members and duplicate pending invitations must be refused

### Must not invent
- extra invitation fields
- bulk invite behavior
- invitation resend behavior
- advanced permission configuration beyond the selected role

### Still needs to specify
- scenario wording
- exact validation and feedback wording
