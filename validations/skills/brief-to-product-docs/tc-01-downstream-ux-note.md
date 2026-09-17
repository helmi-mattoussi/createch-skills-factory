# UX Design Note: Invoice archive flow

## Context
- Source framing: `validations/skills/brief-to-product-docs/tc-01-product-framing-dossier.md`
- Business goal: let the billing team remove completed invoices from the default active list without deleting invoice data
- Actors covered:
  - billing administrator
  - standard billing user

## In scope (UX)
- triggering archive for one invoice from the active invoicing area
- confirmation before archive
- success and refusal feedback after archive attempt
- access to archived invoices through a separate archive access view for billing administrators

## Out of scope (UX)
- restore flow
- permanent deletion
- bulk archive
- archive analytics
- archive search behavior

## User journey

### Nominal path
Step 1: the billing administrator opens the active invoice list.
Step 2: the system shows active invoices and exposes an archive action only on invoices currently eligible for archive.
Step 3: the billing administrator triggers the archive action for one invoice.
Step 4: the system opens a confirmation dialog explaining that the invoice will leave the default active list and remain accessible through the archive access path.
Step 5: the billing administrator confirms the action.
Step 6: the system returns the billing administrator to the active invoice list, removes the archived invoice from that list, and shows a success confirmation.
Step 7: the billing administrator opens the archive access view and can see the archived invoice there.
Outcome: one invoice is archived without deletion and is no longer mixed with active invoices.

### Failure path(s)
Step 1: the billing administrator triggers archive on an invoice that is not eligible under the validated lifecycle rule.
Step 2: the system refuses the action and keeps the invoice in the active list context.
Outcome: the actor sees that archive was not applied.

Step 1: a standard billing user opens the active invoice list.
Step 2: the system does not expose the archive action.
Step 3: if the standard billing user reaches an archive route directly, the system denies access.
Outcome: archive capability remains unavailable to the standard billing user.

Step 1: the billing administrator opens the confirmation dialog.
Step 2: the billing administrator cancels.
Outcome: the invoice remains in the active list and no archive occurs.

## Screen structure

### Screen: Active invoice list
- Entry trigger: the actor opens the invoicing area default list
- Layout summary: invoice list with row-level status visibility and per-invoice actions
- Key elements:
  - invoice identifier and summary fields
  - current lifecycle status
  - archive action visible only for eligible invoices and only to billing administrators
  - no archive action for standard billing users
- Primary action: open or manage an active invoice
- Secondary actions:
  - archive one eligible invoice for billing administrators
- Exit paths:
  - open archive confirmation dialog
  - open invoice detail through existing navigation
  - open archive access view through a separate admin-only entry point

### Screen: Archive confirmation dialog
- Entry trigger: billing administrator selects archive on an eligible invoice
- Layout summary: confirmation message with archive consequence reminder
- Key elements:
  - invoice identifier summary
  - confirmation text explaining that the invoice leaves the active list and is not deleted
  - confirm action
  - cancel action
- Primary action: confirm archive
- Secondary actions:
  - cancel
- Exit paths:
  - on confirm, return to active invoice list with success feedback
  - on cancel, return to active invoice list with no change
  - on refusal, return to active invoice list with refusal feedback

### Screen: Archive access view
- Entry trigger: billing administrator uses a separate archive access path from the invoicing area
- Layout summary: list of archived invoices only
- Key elements:
  - archived invoice list
  - archived state visibility
  - no archive action on already archived items
- Primary action: review archived invoices
- Secondary actions:
  - open invoice detail through existing navigation if available in the product
- Exit paths:
  - return to active invoice list

## UI states

### Invoice archive visibility state
| State | Meaning | Visible elements | Actions available |
|---|---|---|---|
| active and archive-eligible | invoice is still in the active list and can be archived under the validated lifecycle rule | invoice row appears in active list; archive action visible to billing administrator only | billing administrator can trigger archive |
| active but archive-ineligible | invoice is still in the active list but cannot be archived | invoice row appears in active list; archive action hidden or unavailable | no archive action |
| archived | invoice no longer appears in the default active list and is visible in the archive access view | invoice row appears only in archive access view | no archive action in this flow |

### Forbidden transitions
- `active but archive-ineligible` cannot transition directly to `archived` through this flow
- `archived` cannot transition to `archived` again through this flow
- standard billing user cannot trigger any archive transition

## Navigation flow

Active invoice list -> archive confirmation dialog -> confirm -> active invoice list with success feedback
Active invoice list -> archive confirmation dialog -> cancel -> active invoice list unchanged
Active invoice list -> separate archive access entry -> archive access view

## UX edge cases

- Edge case 1: actor cancels confirmation -> no state change and the invoice remains visible in the active list
- Edge case 2: invoice becomes ineligible before confirmation -> refusal feedback and no archive
- Edge case 3: standard billing user reaches archive URL directly -> access denied and no archive visibility

## UX constraints

Constraints from available sources:
- archive must remain distinct from deletion
- archive access must stay restricted to billing administrators
- the exact archive retrieval pattern remains unresolved upstream

## Assumptions

- A1: the archive trigger is exposed from the active invoice list for eligible invoices because this is the smallest interaction path consistent with the framing
- A2: the actor returns to the active invoice list after a successful archive rather than staying in a modal-only state

## Needs validation

- D1: confirm whether the separate archive access path is a dedicated archive view or another validated retrieval pattern
- D2: confirm whether confirmation is a firm product rule or only a conservative UX assumption
- D3: confirm whether the target product lifecycle ever treats `paid` as archive-eligible independently of `finalized`

## Handoff to sdd-spec-writer

### May assume
- the archive action is initiated from the active invoice list
- archive uses a confirmation step before execution
- archived invoices disappear from the default active list after success
- standard billing users do not see or access archive behavior
- archived invoices remain visible through a separate admin-only archive access path

### Must not invent
- restore behavior
- permanent deletion behavior
- bulk archive behavior
- search behavior in the archive access path
- archive eligibility for `paid` invoices without upstream validation
- a broader permission model

### Still needs to specify
- precise scenario wording and acceptance structure
- precise refusal behavior and messages
- exact visibility rules when an invoice becomes ineligible between trigger and confirmation
