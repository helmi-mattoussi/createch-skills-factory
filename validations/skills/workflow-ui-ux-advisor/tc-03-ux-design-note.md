# UX Design Note: Expense approval flow

## Context
- Source framing: `validations/skills/workflow-ui-ux-advisor/fixtures/tc-03-expense-approve-framing.md`
- Business goal: let the organization approve submitted expense reports inside the current web application
- Actors covered:
  - manager
  - finance reviewer
  - employee who submitted the expense report

## In scope (UX)
- review one submitted expense report in the approval flow
- expose approval only for the most restrictive safe actor interpretation
- show resulting approved state after approval

## Out of scope (UX)
- rejection flow
- bulk approval
- reimbursement execution

## User journey

### Nominal path
Step 1: the finance reviewer opens the submitted expense reports list.
Step 2: the system shows submitted expense reports and exposes the approval action for the finance reviewer.
Step 3: the finance reviewer opens one submitted expense report.
Step 4: the system shows the expense details and the approval action.
Step 5: the finance reviewer confirms approval.
Step 6: the system shows the expense report in approved state and returns the actor to the workflow context with success feedback.
Outcome: one submitted expense report is approved.

### Failure path(s)
Step 1: the manager opens the submitted expense reports list.
Step 2: the system does not expose the approval action for that actor in this conservative UX design.
Outcome: approval remains hidden for the unresolved actor until product validation confirms access.

Step 1: the finance reviewer opens an expense report that is no longer submitted.
Step 2: the system refuses the approval action and keeps the actor in the expense detail context.
Outcome: no approval occurs.

## Screen structure

### Screen: Submitted expense reports list
- Entry trigger: actor opens the expense approval workflow
- Layout summary: list of submitted expense reports pending review
- Key elements:
  - expense identity summary
  - current submitted status
  - approval action exposed only for the finance reviewer in this conservative design
- Primary action: open a submitted expense report for review
- Secondary actions:
  - approve one submitted expense report for the finance reviewer
- Exit paths:
  - open one expense report detail

### Screen: Expense report detail
- Entry trigger: actor opens one submitted expense report from the list
- Layout summary: expense details with approval state visibility
- Key elements:
  - expense report details
  - current state
  - approval action exposed only for the finance reviewer in this conservative design
- Primary action: approve the submitted expense report
- Secondary actions:
  - return to submitted expense reports list
- Exit paths:
  - approve and return to workflow context with success feedback
  - return to submitted expense reports list without state change
  - remain on detail page with refusal feedback if approval is no longer allowed

## UI states

### Expense approval state
| State | Meaning | Visible elements | Actions available |
|---|---|---|---|
| submitted | expense report is waiting for approval | submitted status, approval action for finance reviewer only | finance reviewer can approve |
| approved | expense report has already been approved | approved status, no approval action in this flow | no approval action |

### Forbidden transitions
- manager cannot trigger `submitted` to `approved` in this conservative UX design
- `approved` cannot transition to `approved` again in this flow

## Navigation flow

Submitted expense reports list -> expense report detail -> approve -> workflow context with approved state visible
Submitted expense reports list -> expense report detail -> back -> submitted expense reports list

## UX edge cases

- Edge case 1: manager attempts to access approval flow -> approval action hidden and no approval path exposed
- Edge case 2: expense report is no longer submitted when opened -> refusal feedback and no state change

## UX constraints

Constraints from available framing:
- only one submitted expense report is approved at a time
- rejection, bulk approval, and reimbursement execution are out of scope
- approval actor remains unresolved at framing level

## Assumptions

- A1: the UX uses the most restrictive safe interpretation by exposing approval only to the finance reviewer until product confirms whether managers also have access

## Needs validation

- D1: confirm whether approval should be available to finance reviewer only, manager only, or both

## Handoff to sdd-spec-writer

### May assume
- the approval flow starts from the submitted expense reports workflow
- one submitted expense report is approved at a time
- the conservative UX interpretation exposes approval only to the finance reviewer
- approved expense reports no longer expose approval in this flow

### Must not invent
- manager approval access
- a combined approval permission model
- rejection flow
- bulk approval behavior
- reimbursement execution behavior

### Still needs to specify
- exact wording of success and refusal feedback
- exact behavioral contract once the approval actor is validated upstream
