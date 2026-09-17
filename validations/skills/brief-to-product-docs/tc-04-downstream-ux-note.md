# UX Design Note: Member suspension flow

## Context
- Source framing: `validations/skills/brief-to-product-docs/tc-04-product-framing-dossier.md`
- Business goal: let workspace owners suspend a member without deleting the account while preserving audit visibility
- Actors covered:
  - workspace owner
  - workspace manager

## In scope (UX)
- trigger suspension for one member from the active member management area
- confirmation before suspension
- success and refusal feedback
- access to suspended members through a dedicated suspended members view for workspace owners

## Out of scope (UX)
- deletion
- bulk suspension
- restore

## User journey

### Nominal path
Step 1: the workspace owner opens the active member list.
Step 2: the system shows a suspension action for eligible members.
Step 3: the workspace owner triggers suspension for one member.
Step 4: the system opens a confirmation dialog explaining that the member will lose active access and remain visible in the dedicated suspended members view.
Step 5: the workspace owner confirms the action.
Step 6: the system returns to the active member list, removes the suspended member from that list, and shows success feedback.
Step 7: the workspace owner opens the dedicated suspended members view and can see the suspended member there.
Outcome: the member is suspended without deletion.

### Failure path(s)
Step 1: a workspace manager opens the active member list.
Step 2: the system does not expose suspension for that actor.
Step 3: if the workspace manager reaches a suspension route directly, the system denies access.
Outcome: only workspace owners can suspend members.

Step 1: the workspace owner opens the confirmation dialog.
Step 2: the workspace owner cancels.
Outcome: no suspension occurs and the member stays in the active member list.

## Screen structure

### Screen: Active member list
- Entry trigger: actor opens member management
- Layout summary: active members with per-member actions
- Key elements:
  - member identity summary
  - active access status
  - suspension action visible only to workspace owners
- Primary action: manage active members
- Secondary actions:
  - suspend one member for workspace owners
- Exit paths:
  - open suspension confirmation dialog
  - open dedicated suspended members view

### Screen: Suspension confirmation dialog
- Entry trigger: workspace owner selects suspend for one member
- Layout summary: confirmation text and consequences
- Key elements:
  - member identity summary
  - confirmation message
  - confirm action
  - cancel action
- Primary action: confirm suspension
- Secondary actions:
  - cancel
- Exit paths:
  - on confirm, return to active member list with success feedback
  - on cancel, return to active member list unchanged
  - on refusal, return to active member list with denial feedback

### Screen: Suspended members view
- Entry trigger: workspace owner opens the dedicated suspended members view
- Layout summary: suspended members only
- Key elements:
  - suspended member list
  - suspended status visibility
- Primary action: review suspended members
- Secondary actions:
  - return to active member list
- Exit paths:
  - open active member list

## UI states

### Member suspension visibility state
| State | Meaning | Visible elements | Actions available |
|---|---|---|---|
| active | member is active in the workspace | active member list row | workspace owner can trigger suspension |
| suspended | member is no longer active and appears only in the dedicated suspended members view | suspended member row in suspended members view | no suspension action in this flow |

### Forbidden transitions
- workspace manager cannot trigger `active` to `suspended`
- `suspended` cannot transition to `suspended` again in this flow

## Navigation flow

Active member list -> suspension confirmation dialog -> confirm -> active member list with success feedback
Active member list -> suspension confirmation dialog -> cancel -> active member list unchanged
Active member list -> dedicated suspended members view

## UX edge cases

- Edge case 1: workspace manager reaches suspension URL directly -> access denied
- Edge case 2: owner cancels confirmation -> member remains active

## UX constraints

Constraints from available sources:
- action is suspension only, not deletion
- the dedicated suspended members view is part of MVP
- only workspace owners may act on suspension

## Assumptions

- none required for the core flow

## Needs validation

- none for the core flow

## Handoff to sdd-spec-writer

### May assume
- suspension starts from the active member list
- confirmation is mandatory
- suspended members leave the active member list
- suspended members remain visible in a dedicated suspended members view for workspace owners
- workspace managers cannot suspend

### Must not invent
- deletion behavior
- bulk suspension behavior
- restore behavior
- manager suspension permission

### Still needs to specify
- precise scenario wording
- precise denial and confirmation messages
