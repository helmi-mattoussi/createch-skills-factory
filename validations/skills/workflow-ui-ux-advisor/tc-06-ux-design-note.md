# UX Design Note: Project archive flow

## Context
- Source framing: `validations/skills/workflow-ui-ux-advisor/fixtures/tc-06-project-archive-framing.md`
- Business goal: let project administrators archive completed projects without deleting project data
- Actors covered:
  - project administrator
  - project contributor

## In scope (UX)
- trigger archive for one completed project from the active project list
- conservative confirmation before archive
- success and refusal feedback
- access to archived projects through a separate archive area

## Out of scope (UX)
- deletion
- restore
- bulk archive

## User journey

### Nominal path
Step 1: the project administrator opens the active project list.
Step 2: the system shows active and completed projects that are still in the active list and exposes an archive action only for completed projects and only to project administrators.
Step 3: the project administrator selects archive for one completed project.
Step 4: the system opens a confirmation dialog explaining that the project will leave the active list and remain available in the archive area.
Step 5: the project administrator confirms the action.
Step 6: the system returns the administrator to the active project list, removes the archived project from that list, and shows success feedback.
Step 7: the project administrator opens the archive area and sees the archived project there.
Outcome: one completed project is archived without deletion.

### Failure path(s)
Step 1: the project contributor opens the active project list.
Step 2: the system does not expose the archive action for that actor.
Step 3: if the contributor reaches an archive route directly, the system denies access.
Outcome: only project administrators can archive projects.

Step 1: the project administrator selects archive for a project that is no longer eligible.
Step 2: the system refuses the action and keeps the project in the active list context.
Outcome: no archive occurs and the actor sees refusal feedback.

Step 1: the project administrator opens the confirmation dialog.
Step 2: the project administrator cancels.
Outcome: no archive occurs and the project remains visible in the active list.

## Screen structure

### Screen: Active project list
- Entry trigger: actor opens project management list
- Layout summary: active list of projects with row-level state and available actions
- Key elements:
  - project identity summary
  - project completion status
  - archive action visible only for completed projects and only to project administrators
  - entry point to the separate archive area
- Primary action: manage active and completed projects still in the active list
- Secondary actions:
  - archive one completed project for project administrators
  - open the archive area
- Exit paths:
  - open archive confirmation dialog
  - open the archive area

### Screen: Archive confirmation dialog
- Entry trigger: project administrator selects archive on one completed project
- Layout summary: focused confirmation dialog describing archive consequences
- Key elements:
  - project identity summary
  - message that the project leaves the active list
  - message that the project remains available in the archive area
  - confirm action
  - cancel action
- Primary action: confirm archive
- Secondary actions:
  - cancel
- Exit paths:
  - on confirm, return to active project list with success feedback
  - on cancel, return to active project list unchanged
  - on refusal, return to active project list with denial feedback

### Screen: Archive area
- Entry trigger: project administrator opens the separate archive area
- Layout summary: archived projects only
- Key elements:
  - archived project list
  - archived visibility state
- Primary action: review archived projects
- Secondary actions:
  - return to the active project list
- Exit paths:
  - return to the active project list

## UI states

### Project archive visibility state
| State | Meaning | Visible elements | Actions available |
|---|---|---|---|
| completed and archive-eligible | completed project still visible in the active list | active project row with archive action for project administrators | project administrator can trigger archive |
| archived | project visible only in the archive area | archived project row in archive area | no archive action in this flow |

### Forbidden transitions
- project contributor cannot trigger `completed and archive-eligible` to `archived`
- `archived` cannot transition to `archived` again in this flow

## Navigation flow

Active project list -> archive confirmation dialog -> confirm -> active project list with success feedback
Active project list -> archive confirmation dialog -> cancel -> active project list unchanged
Active project list -> archive area -> active project list

## UX edge cases

- Edge case 1: project contributor reaches archive URL directly -> access denied
- Edge case 2: project becomes ineligible before confirmation -> refusal feedback and no state change
- Edge case 3: project administrator cancels confirmation -> project remains in the active list

## UX constraints

Constraints from available framing:
- archive is not deletion
- only completed projects may be archived
- only project administrators may archive
- archived projects remain available in a separate archive area

## Assumptions

- A1: a confirmation step is added conservatively because archive is an irreversible visibility change in this flow, even though framing does not explicitly validate confirmation yet

## Needs validation

- D1: confirm whether confirmation is a validated product rule or only a conservative UX treatment for MVP

## Handoff to sdd-spec-writer

### May assume
- the archive flow starts from the active project list
- archive is available only to project administrators on completed projects
- the UX currently uses a confirmation dialog before archive
- successful archive removes the project from the active list and keeps it visible in the archive area
- cancellation leaves the project unchanged in the active list

### Must not invent
- deletion behavior
- restore behavior
- bulk archive behavior
- contributor access to archive
- a different primary trigger location outside the active project list

### Still needs to specify
- exact success and refusal wording
- exact refusal scenario wording
- whether confirmation is formal product behavior or a conservative UX assumption
