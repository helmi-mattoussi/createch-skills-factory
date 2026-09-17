# UX Design Note: Invoice archive flow

## Context
- Source framing: `validations/skills/workflow-ui-ux-advisor/fixtures/tc-05-invoice-archive-framing.md`
- Business goal: let billing administrators archive finalized invoices without deleting invoice data
- Actors covered:
  - billing administrator
  - billing viewer

## In scope (UX)
- trigger archive for one finalized invoice from the active invoice list
- show archive confirmation
- show success or refusal feedback
- allow billing administrators to access archived invoices through a separate archive view

## Out of scope (UX)
- search in the archive view
- filtering in the archive view or active invoice list
- restore
- bulk archive

## User journey

### Nominal path
Step 1: the billing administrator opens the active invoice list.
Step 2: the system shows finalized invoices and exposes the archive action only to billing administrators on finalized invoices.
Step 3: the billing administrator selects archive for one finalized invoice.
Step 4: the system opens a confirmation dialog explaining that the invoice will leave the active list and remain available in the archive view.
Step 5: the billing administrator confirms the action.
Step 6: the system returns the billing administrator to the active invoice list, removes the archived invoice from that list, and shows success feedback.
Step 7: the billing administrator opens the archive view and sees the archived invoice there.
Outcome: one finalized invoice is archived without deletion.

### Failure path(s)
Step 1: the billing viewer opens the active invoice list.
Step 2: the system does not expose the archive action for that actor.
Outcome: archive remains unavailable to the billing viewer.

Step 1: the billing administrator attempts to archive an invoice that is no longer finalized.
Step 2: the system refuses the action and keeps the invoice in the active list context.
Outcome: no archive occurs.

## Screen structure

### Screen: Active invoice list
- Entry trigger: actor opens the invoicing list
- Layout summary: active invoice list with row-level state and actions
- Key elements:
  - invoice identity summary
  - invoice lifecycle state
  - archive action visible only for finalized invoices and only to billing administrators
  - entry point to the separate archive view
- Primary action: manage active invoices
- Secondary actions:
  - archive one finalized invoice for billing administrators
  - open the archive view
- Exit paths:
  - open archive confirmation dialog
  - open the archive view

### Screen: Archive confirmation dialog
- Entry trigger: billing administrator selects archive on one finalized invoice
- Layout summary: focused confirmation dialog describing archive consequences
- Key elements:
  - invoice identity summary
  - message that the invoice leaves the active list
  - message that the invoice remains available in the archive view
  - confirm action
  - cancel action
- Primary action: confirm archive
- Secondary actions:
  - cancel
- Exit paths:
  - on confirm, return to the active invoice list with success feedback
  - on cancel, return to the active invoice list unchanged
  - on refusal, return to the active invoice list with denial feedback

### Screen: Archive view
- Entry trigger: billing administrator opens the separate archive view
- Layout summary: archived invoices only
- Key elements:
  - archived invoice list
  - archived visibility state
- Primary action: review archived invoices
- Secondary actions:
  - return to the active invoice list
- Exit paths:
  - return to the active invoice list

## UI states

### Invoice archive visibility state
| State | Meaning | Visible elements | Actions available |
|---|---|---|---|
| finalized and archive-eligible | finalized invoice still visible in the active list | invoice row with archive action for billing administrator only | billing administrator can trigger archive |
| archived | invoice visible only in the archive view | archived invoice row in archive view | no archive action in this flow |

### Forbidden transitions
- billing viewer cannot trigger `finalized and archive-eligible` to `archived`
- `archived` cannot transition to `archived` again in this flow

## Navigation flow

Active invoice list -> archive confirmation dialog -> confirm -> active invoice list with success feedback
Active invoice list -> archive confirmation dialog -> cancel -> active invoice list unchanged
Active invoice list -> archive view -> active invoice list

## UX edge cases

- Edge case 1: billing viewer reaches archive route directly -> access denied
- Edge case 2: invoice is no longer finalized when the actor confirms -> refusal feedback and no state change

## UX constraints

Constraints from available framing:
- archive applies only to finalized invoices
- archive is restricted to billing administrators
- search and filtering are out of scope
- restore and bulk archive are out of scope

## Assumptions

- none required for the core flow

## Needs validation

- none for the scoped flow

## Handoff to sdd-spec-writer

### May assume
- the archive flow starts from the active invoice list
- archive confirmation is part of the flow
- archive is visible only to billing administrators on finalized invoices
- archived invoices remain available in the archive view

### Must not invent
- search behavior
- filtering behavior
- restore behavior
- bulk archive behavior
- broader actor access

### Still needs to specify
- exact message wording
- exact refusal wording
