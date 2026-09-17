# Product Framing Dossier

## 1. Header
- Topic: Simpler reminder action for overdue invoices in the current web application
- Sources:
  - `validations/skills/brief-to-product-docs/fixtures/tc-03-partial-jira-overdue-invoice-reminder.md`
- Status: PARTIAL - FOLLOW-UPS REQUIRED
- Owner: Product review pending

## 2. Business objective
- Objective: Reduce manual effort when following up on overdue invoices by providing a simpler reminder action in the web application.
- Expected value:
  - reduce manual reminder work
  - accelerate overdue invoice follow-up
  - keep the first version narrower than a full dunning workflow

## 3. Problem to solve
- Current pain/problem:
  - overdue invoice follow-up is too manual
  - the team lacks a simpler in-product reminder action
- Why it matters now:
  - reminder work already creates operational friction
  - a narrow reminder action may solve the immediate pain without redesigning collections

## 4. Scope
### In scope
- frame a first-version reminder action for overdue invoices
- keep the action inside the current web application
- keep the first version narrower than a full dunning workflow

### Out of scope
- full dunning workflow
- custom email editor
- scheduled reminders
- bulk reminder campaigns

## 5. Actors
- Primary actors:
  - not yet validated; the ticket implies an internal operational actor but does not identify the responsible role
- Secondary actors:
  - customer receiving the reminder

## 6. Known business rules
- R1: The first version should stay simple.
- R2: Full dunning workflow is out of scope.
- R3: Custom email editing is out of scope.
- R4: Scheduled reminders are out of scope.
- R5: Bulk reminder campaigns are out of scope.

## 7. Assumptions
- A1: The intended actor is likely part of billing or finance operations, but the exact role must not be invented.
- A2: The reminder action is intended for already overdue invoices, but the exact eligibility rule is not yet defined.

## 8. Open questions
- Q1: Which actor or role is allowed to trigger the reminder?
- Q2: What exact rule makes an invoice reminder-eligible in MVP?
- Q3: Does MVP allow more than one reminder per invoice?
- Q4: Does the reminder use an existing communication template or require a fixed default message?

## 9. Points to arbitrate / Needs validation
- D1: Confirm the responsible actor boundary for the reminder action.
- D2: Confirm whether repeated reminders need any cooldown or cap in MVP.

## 10. Risks / vigilance points
- downstream work must not invent the authorized actor
- downstream work must not invent reminder eligibility rules
- the request must not silently expand into scheduling, bulk reminders, or a full dunning workflow

## 11. Source-of-truth and conflicts
- Sources used:
  - partial Jira ticket in `tc-03-partial-jira-overdue-invoice-reminder.md`
- Conflicts detected:
  - none explicit, but the ticket is incomplete on actors and rules
- Provisional resolution:
  - keep the business objective and out-of-scope stable
  - leave actor and eligibility rules open instead of inventing them

## 12. Ambiguity log references
- none required for this run

## 13. Readiness for specification
- Ready for spec: Partial
- Stable enough:
  - business goal is identifiable
  - first-level out-of-scope is clear
  - the reminder intent is narrower than a full collections redesign
- Blocking items:
  - authorized actor is not validated
  - reminder eligibility rule is not validated

## 14. Product Quality Gate
- Decision: PASS WITH EXPLICIT FOLLOW-UPS
- Reason:
  - the business objective is clear enough to frame
  - the ticket remains incomplete on actors and behavioral rules, so downstream work must stay constrained
- Follow-ups:
  - validate the actor boundary
  - validate reminder eligibility
  - validate whether repeated reminders need MVP limits

## 15. Handoff to sdd-spec-writer
### May assume
- the subject is an overdue-invoice reminder action, not a full dunning redesign
- scheduled reminders are out of scope
- bulk reminder campaigns are out of scope
- custom email editing is out of scope

### Must not invent
- the authorized actor
- the exact overdue eligibility rule
- repeat-reminder limits or cooldowns
- scheduling behavior
- bulk reminder behavior

### Still needs to specify
- none until the actor boundary and reminder eligibility rule are validated
