# UX Design Note: Workspace member invitation flow

## Context
- Source framing: `validations/skills/workflow-ui-ux-advisor/fixtures/tc-02-invite-member-framing.md`
- Business goal: let workspace administrators invite one new member from the web application
- Actors covered:
  - workspace administrator
  - invited user

## In scope (UX)
- open the invite-member flow from workspace member management
- complete and submit the invitation form
- show validation, success, and refusal outcomes

## Out of scope (UX)
- bulk invite
- editing a sent invitation
- resending an invitation
- advanced permission configuration

## User journey

### Nominal path
Step 1: the workspace administrator opens member management.
Step 2: the system shows the current members and an `Invite member` action.
Step 3: the workspace administrator opens the invite form.
Step 4: the system shows the invitation form with `Email`, `Role`, and `Note`.
Step 5: the workspace administrator enters a valid email, selects a role, and optionally adds a note.
Step 6: the workspace administrator submits the form.
Step 7: the system creates the invitation, closes the form context, and shows success feedback in member management.
Outcome: one invitation is created for the selected email and role.

### Failure path(s)
Step 1: the workspace administrator opens the invite form.
Step 2: the workspace administrator submits the form with a missing required field or invalid email.
Step 3: the system keeps the form open, highlights the invalid field, and shows field-level validation feedback.
Outcome: no invitation is created until the form is valid.

Step 1: the workspace administrator submits a valid-looking form.
Step 2: the system detects that the email already belongs to an active workspace member or already has a pending invitation in the same workspace.
Step 3: the system keeps the form open and shows refusal feedback linked to the email field or form-level error area.
Outcome: no duplicate invitation is created.

## Screen structure

### Screen: Member management
- Entry trigger: actor opens workspace member management
- Layout summary: current members list and member-management actions
- Key elements:
  - current member list
  - `Invite member` action visible to workspace administrators
- Primary action: manage workspace members
- Secondary actions:
  - open the invite-member form
- Exit paths:
  - open the invitation form

### Screen: Invite member form
- Entry trigger: workspace administrator selects `Invite member`
- Layout summary: focused form for creating one invitation
- Key elements:
  - `Email` field
  - `Role` field
  - `Note` field
  - submit action
  - cancel action
- Primary action: submit the invitation form
- Secondary actions:
  - cancel and return to member management
- Exit paths:
  - on success, return to member management with success feedback
  - on validation error, remain on the form with field-level feedback
  - on duplicate refusal, remain on the form with refusal feedback
  - on cancel, return to member management without creating an invitation

## UI states

### Invite member form state
| State | Meaning | Visible elements | Actions available |
|---|---|---|---|
| empty form | form opened but not yet completed | empty `Email`, `Role`, optional `Note`, submit and cancel | submit, cancel |
| validation error | one or more required or formatted inputs are invalid | invalid field markers and validation feedback | correct fields, resubmit, cancel |
| duplicate refusal | email conflicts with an existing member or pending invitation | refusal feedback tied to email or form-level error | change email, resubmit, cancel |
| submission success | invitation created successfully | success feedback in member management after returning from the form | continue managing members |

### Forbidden transitions
- the flow does not allow submission success when `Email` is invalid
- the flow does not allow submission success when `Role` is missing
- the flow does not allow submission success for an already active or already pending email in the same workspace

## Form structure

### Form: Invite member
| Field | Type | Required | Validation |
|---|---|---|---|
| `Email` | email | Yes | must be a valid email format; must not belong to an active workspace member; must not already have a pending invitation in the same workspace |
| `Role` | select | Yes | must be selected from the workspace roles already available in the product |
| `Note` | textarea | No | no blocking validation required in the current scope |

Submission behavior:
- Success: create one invitation, return to member management, and show success feedback
- Validation error: keep the form open and show field-level feedback
- System error or duplicate refusal: keep the form open and show refusal feedback without creating an invitation

## Navigation flow

Member management -> invite member form -> submit -> member management with success feedback
Member management -> invite member form -> validation error -> invite member form
Member management -> invite member form -> duplicate refusal -> invite member form
Member management -> invite member form -> cancel -> member management

## UX edge cases

- Edge case 1: actor submits without selecting a role -> form remains open with field-level feedback
- Edge case 2: actor uses an already invited email -> form remains open with refusal feedback
- Edge case 3: actor cancels the form -> no invitation is created and member management remains unchanged

## UX constraints

Constraints from available framing:
- one invitation is created at a time
- only workspace administrators may invite
- bulk invite, resend, and editing sent invitations are out of scope

## Assumptions

- none required for the scoped form flow

## Needs validation

- none for the scoped form flow

## Handoff to sdd-spec-writer

### May assume
- the flow starts from member management
- the invitation form contains only `Email`, `Role`, and `Note`
- `Email` and `Role` are required and `Note` is optional
- the form stays open on validation or duplicate refusal
- success returns the actor to member management with success feedback

### Must not invent
- additional invitation fields
- bulk invite behavior
- resend behavior
- advanced permission configuration
- alternate success or failure navigation outside this flow

### Still needs to specify
- exact feedback wording
- precise scenario wording for validation and duplicate refusal
