# Examples

Use these examples to recognize strong UX Design Note patterns and common anti-patterns.

The goal is not to copy examples mechanically.
The goal is to imitate:
- the correct interaction-level of description (not visual, not technical)
- the explicit user journey with failure paths
- the clear screen structure with entry triggers and exit paths
- the disciplined scope control
- the honest handoff to sdd-spec-writer

---

# Example 1 — Simple action flow with confirmation

## Input (from Product Framing Dossier)

- workspace admin can archive a project from its detail page
- only active or paused projects can be archived
- archived projects are hidden from standard active views
- restore is out of scope

## Good UX Design Note output

```markdown
# UX Design Note: Archive a project

## Context
- Source framing: docs/product-framing/projects/archive-project.md
- Business goal: allow workspace admins to remove inactive projects from standard views
- Actors covered: workspace admin

## In scope (UX)
- archive action from the project detail page
- confirmation step before archiving
- feedback on successful archive
- error handling if archive fails

## Out of scope (UX)
- project restore flow
- bulk archive from the list view
- archive from the project list view
- any notification to project members

## User journey

### Nominal path
Step 1: workspace admin opens a project detail page (project is in active or paused state)
Step 2: workspace admin selects the archive action
Step 3: system shows a confirmation dialog
Step 4: workspace admin confirms the archive
Step 5: system archives the project and redirects to the active project list
Outcome: project is no longer visible in standard active project views

### Failure path — project already archived
Step 1: workspace admin opens a project detail page (project is already archived)
Step 2: archive action is not available (hidden or disabled)
Outcome: admin cannot trigger the archive action on an already archived project

### Failure path — system error on archive
Step 1: workspace admin confirms archive
Step 2: system encounters an error
Step 3: system shows an error message on the detail page
Outcome: project remains in its current state, admin can retry

## Screen structure

### Screen: Project Detail Page (active or paused project)
- Entry trigger: workspace admin navigates to a project detail page
- Key elements: project name, status badge, project details, team section
- Actions available: Edit (always visible), Archive (only when active or paused, only for workspace admins)
- Exit paths: navigate back to list, confirm archive → archive confirmation dialog

### Screen: Archive Confirmation Dialog
- Entry trigger: workspace admin selects Archive on the detail page
- Key elements: confirmation message ("Archive [Project Name]? It will be hidden from active views."), Confirm button, Cancel button
- Actions available: Confirm archive, Cancel
- Exit paths: Cancel → return to detail page, Confirm → archive processing → project list

## UI states

### Project (on detail page)
| State | Archive action visible | Archive action enabled |
|---|---|---|
| active | yes (admin only) | yes |
| paused | yes (admin only) | yes |
| archived | no | n/a |

## Navigation flow

Project list → Project detail page → [archive selected] → Confirmation dialog
→ [confirmed] → Archive processing → Project list (project no longer visible)
→ [cancelled] → Project detail page

## UX edge cases

- Empty archive confirmation: if project name is long, truncate with ellipsis in the dialog title
- Slow system response: show a loading state after confirmation, disable the Confirm button to prevent double submission

## UX constraints

- Only workspace admins see the archive action (from product framing)
- Archive action must not be available for already-archived projects (from product framing)

## Assumptions

- A1: a confirmation dialog is used because archiving is not easily reversible. Can be removed if product decides the action is low-stakes.
- A2: after successful archive, the user is redirected to the active project list (most common expected destination)

## Needs validation

- none

## Handoff to sdd-spec-writer

### May assume
- archive action is on the project detail page
- only workspace admins see the archive action
- only active or paused projects show the archive action
- a confirmation dialog is shown before archive
- successful archive redirects to the project list

### Must not invent
- restore behavior (it is out of scope)
- bulk archive behavior (it is out of scope)
- notification behavior (it is out of scope)

### Still needs to specify
- the exact behavioral contract for state restriction (what the system returns when a non-eligible project is accessed directly via URL with the archive action)
- error wording for the system error scenario
```

## Why this is a strong UX Design Note

- nominal path and two failure paths are covered
- screen structure is precise with entry triggers and exit paths
- UI states are a simple table that maps directly to feature scenarios
- scope is tightly controlled with explicit out-of-scope
- handoff is specific and operationally useful to sdd-spec-writer

---

# Example 2 — Form-based flow

## Input (from Product Framing Dossier)

- workspace admin can invite a teammate by email
- invitation requires a valid email format
- duplicate pending invitations are not allowed
- only workspace admins can send invitations

## Good UX Design Note output

```markdown
# UX Design Note: Invite a teammate

## Context
- Source framing: docs/product-framing/workspace/invite-teammate.md
- Business goal: allow workspace admins to invite new members by email
- Actors covered: workspace admin

## In scope (UX)
- invite form accessible from workspace settings
- email field with validation feedback
- invitation submission and confirmation
- duplicate invitation error handling

## Out of scope (UX)
- invitation acceptance flow (separate feature)
- bulk invitation
- invitation by shareable link
- role selection at invitation time

## User journey

### Nominal path
Step 1: workspace admin opens workspace settings and selects Members
Step 2: workspace admin selects Invite a teammate
Step 3: system shows the invite form with an email field
Step 4: workspace admin enters a valid email and submits
Step 5: system creates a pending invitation and shows a success message
Outcome: a pending invitation exists for the entered email

### Failure path — invalid email format
Step 4b: workspace admin enters an invalid email format and submits
Step 5b: system shows a validation error below the email field
Outcome: invitation is not sent, admin can correct the email

### Failure path — duplicate pending invitation
Step 4c: workspace admin enters an email with an existing pending invitation
Step 5c: system shows an error message explaining a pending invitation already exists
Outcome: invitation is not sent, admin is informed

## Screen structure

### Screen: Member Settings — Invite Form
- Entry trigger: workspace admin selects "Invite a teammate" from Members settings
- Key elements: email input field (required), Submit button, Cancel / close
- Actions available: Submit invitation, Cancel
- Exit paths: Cancel → return to Members list, Submit success → Members list with success message, Submit error → same form with error message

## Form structure

### Invite Teammate Form
| Field | Type | Required | Validation |
|---|---|---|---|
| Email | email | Yes | valid email format |

Submission behavior:
- Success: pending invitation created, user returned to Members list with success banner
- Validation error (invalid format): error shown below email field, form remains open
- Business error (duplicate): error shown as form-level error, form remains open with submitted value preserved

## UI states

No complex state model. The form has two states: idle and submitted-with-error.

## Navigation flow

Workspace settings → Members → [Invite teammate selected] → Invite Form
→ [success] → Members list (with success banner)
→ [error] → Invite Form (with error message)

## UX edge cases

- Invited email already a workspace member: behavior not defined in framing — marked as Needs validation
- Form submitted twice: Confirm button should be disabled after first submission to prevent double submission

## UX constraints

- Only workspace admins see the Invite teammate action
- Duplicate pending invitations are rejected (from framing)

## Assumptions

- A1: after successful invitation, the user is returned to the Members list where the pending invitation is visible

## Needs validation

- D1: what happens if the invited email belongs to an existing workspace member? Should a separate error message be shown?

## Handoff to sdd-spec-writer

### May assume
- invite form is in workspace settings → Members section
- the form has a single email field
- validation error appears below the email field
- duplicate pending invitation is rejected with a form-level error
- success returns the admin to the Members list

### Must not invent
- bulk invitation behavior (out of scope)
- role selection at invitation time (out of scope)
- invitation acceptance flow (separate feature)

### Still needs to specify
- exact error wording for duplicate invitation
- exact behavior when invited email belongs to an existing member (D1)
```

## Why this is a strong UX Design Note

- three journey paths are covered (success, invalid email, duplicate)
- the form is precise field-by-field with validation behavior
- the D1 Needs validation is honest and operationally useful
- the handoff gives sdd-spec-writer clear grounding for the three main scenarios

---

# Anti-patterns to avoid

Do not produce UX Design Notes that:
- describe visual design (colors, fonts, card styles) instead of interaction structure
- skip the failure paths and only describe the happy path
- list screen names without describing their content or triggers
- describe API calls or event handlers instead of user-level interactions
- add features not in scope to make the flow feel more complete
- present unresolved UX decisions as confident design choices
- provide only a very vague handoff to sdd-spec-writer
