# UX Design Note: Member suspension flow

## Context
- Source framing: `validations/skills/brief-to-product-docs/tc-04-product-framing-dossier.md`
- Business goal: allow workspace owners to suspend a member without deleting the account while preserving audit visibility
- Actors covered:
  - workspace owner
  - workspace manager

## In scope (UX)
- triggering suspension for one member from the active member management area
- confirmation before suspension
- success and refusal feedback
- access to suspended members through a dedicated suspended members view for workspace owners

## Out of scope (UX)
- deletion
- bulk suspension
- restore
- self-service member suspension

## User journey

### Nominal path
Step 1: the workspace owner opens the active member list in member management.
Step 2: the system shows active members and exposes a suspension action on eligible member rows for workspace owners only.
Step 3: the workspace owner selects the suspension action for one member.
Step 4: the system opens a confirmation dialog explaining that the member will lose active workspace access and remain visible in the dedicated suspended members view.
Step 5: the workspace owner confirms the action.
Step 6: the system returns the workspace owner to the active member list, removes the suspended member from that list, and shows success feedback.
Step 7: the workspace owner opens the dedicated suspended members view and sees the suspended member there.
Outcome: one member is suspended without deletion and leaves the active list.

### Failure path(s)
Step 1: a workspace manager opens the active member list.
Step 2: the system does not expose the suspension action for that actor.
Step 3: if the workspace manager reaches a suspension route directly, the system denies access and keeps the actor out of the suspension flow.
Outcome: only workspace owners can suspend members.

Step 1: the workspace owner opens the confirmation dialog.
Step 2: the workspace owner cancels the action.
Step 3: the system closes the dialog and keeps the member in the active member list.
Outcome: no suspension occurs.

## Screen structure

### Screen: Active member list
- Entry trigger: the actor opens member management in the current web application
- Layout summary: list of active members with per-member actions
- Key elements:
  - member identity summary
  - active membership status
  - suspension action visible only to workspace owners
  - entry point to the dedicated suspended members view for workspace owners
- Primary action: manage active members
- Secondary actions:
  - suspend one member for workspace owners
  - open the dedicated suspended members view
- Exit paths:
  - open the suspension confirmation dialog
  - navigate to the dedicated suspended members view
  - continue to existing member detail or management paths outside this UX note

### Screen: Suspension confirmation dialog
- Entry trigger: workspace owner selects suspension for one active member
- Layout summary: focused confirmation dialog describing the consequence of suspension
- Key elements:
  - member identity summary
  - message that active workspace access will stop
  - message that the member remains visible in the dedicated suspended members view
  - confirm action
  - cancel action
- Primary action: confirm suspension
- Secondary actions:
  - cancel
- Exit paths:
  - on confirm, return to the active member list with success feedback
  - on cancel, return to the active member list unchanged
  - on refusal or stale access condition, return to the active member list with denial feedback

### Screen: Dedicated suspended members view
- Entry trigger: workspace owner opens the dedicated suspended members view from member management
- Layout summary: list of suspended members only
- Key elements:
  - suspended member list
  - suspended status visibility
  - return path to the active member list
- Primary action: review suspended members
- Secondary actions:
  - return to the active member list
- Exit paths:
  - navigate back to the active member list

## UI states

### Member suspension visibility state
| State | Meaning | Visible elements | Actions available |
|---|---|---|---|
| active | member is active in the workspace and visible in the active member list | active member row in the active member list | workspace owner can trigger suspension |
| suspended | member is no longer active and is visible only in the dedicated suspended members view | suspended member row in the dedicated suspended members view | no suspension action in this flow |

### Forbidden transitions
- workspace manager cannot trigger `active` to `suspended`
- `suspended` cannot transition to `suspended` again in this flow
- this flow does not include any transition from `suspended` back to `active`

## Navigation flow

Active member list -> suspension confirmation dialog -> confirm -> active member list with success feedback
Active member list -> suspension confirmation dialog -> cancel -> active member list unchanged
Active member list -> dedicated suspended members view -> active member list

## UX edge cases

- Edge case 1: workspace manager reaches a suspension route directly -> access denied and no suspension UI is shown
- Edge case 2: workspace owner cancels confirmation -> member remains active and visible in the active member list
- Edge case 3: member is no longer eligible by the time the owner confirms -> denial feedback and no state change

## UX constraints

Constraints from available framing:
- suspension is not deletion
- only workspace owners may suspend
- suspended members remain visible in a dedicated suspended members view for workspace owners
- bulk suspension and restore are out of scope

## Assumptions

- A1: the suspension action is triggered from the active member list because the framing grounds the action inside existing member management and does not require a separate detail-only entry point

## Needs validation

- none for the first-version UX flow

## Handoff to sdd-spec-writer

### May assume
- the suspension flow starts from the active member list
- the suspension action is visible only to workspace owners
- suspension requires an explicit confirmation dialog
- a successful suspension removes the member from the active member list
- suspended members remain visible in a dedicated suspended members view for workspace owners
- cancellation returns the actor to the active member list without any state change

### Must not invent
- deletion behavior
- bulk suspension behavior
- restore behavior
- workspace manager permission to suspend
- a broader visibility model for suspended members
- an alternate primary trigger path outside member management

### Still needs to specify
- exact scenario wording
- exact denial and success message wording
- precise stale-state refusal behavior
