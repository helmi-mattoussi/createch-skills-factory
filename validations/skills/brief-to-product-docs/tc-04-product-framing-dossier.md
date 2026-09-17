# Product Framing Dossier

## 1. Header
- Topic: Member suspension in the existing web application member management area
- Sources:
  - `validations/skills/brief-to-product-docs/fixtures/tc-04-pd-member-suspension.md`
  - `validations/skills/brief-to-product-docs/fixtures/tc-04-jira-member-suspension.md`
- Status: PASS
- Owner: Product decision already validated in PD-117

## 2. Business objective
- Objective: Allow workspace owners to suspend a member without deleting the account so active member management stays clean while preserving audit visibility.
- Expected value:
  - remove no-longer-active members from the active list
  - preserve a recoverable record of suspended members
  - avoid deletion-driven workarounds

## 3. Problem to solve
- Current pain/problem:
  - active member lists become cluttered by members who should no longer have active workspace access
  - teams need a safe action that removes active access without deleting the account
- Why it matters now:
  - the product decision is already validated
  - the current request pressures toward deletion and permission broadening, which must be constrained before downstream work

## 4. Scope
### In scope
- suspend one workspace member
- remove the suspended member from the active member list
- keep suspended members visible in a dedicated suspended members view for workspace owners
- restrict the suspension capability to workspace owners
- require explicit confirmation before suspension

### Out of scope
- deletion
- bulk suspension
- restore
- non-web behavior

## 5. Actors
- Primary actors:
  - workspace owner
- Secondary actors:
  - workspace manager
  - regular workspace member

## 6. Known business rules
- R1: Only workspace owners may suspend a member.
- R2: Suspension removes active workspace access immediately.
- R3: Suspended members remain visible in a dedicated suspended members view for workspace owners.
- R4: Suspension is not deletion.
- R5: The action requires explicit confirmation.

## 7. Assumptions
- A1: The existing product already distinguishes workspace owner from workspace manager in a usable way for downstream work.

## 8. Open questions
- Q1: None at framing level for MVP.

## 9. Points to arbitrate / Needs validation
- D1: None for MVP because the validated PD already settles permissions, scope, and confirmation.

## 10. Risks / vigilance points
- downstream work must not broaden suspension rights to workspace managers
- downstream work must not absorb deletion or bulk suspension from the Jira request
- the dedicated suspended members view must remain owner-scoped

## 11. Source-of-truth and conflicts
- Sources used:
  - validated PD-117
  - Jira ticket requesting faster member deactivation
- Conflicts detected:
  - Jira proposes workspace managers as actors, while PD-117 limits the action to workspace owners
  - Jira suggests deletion, while PD-117 explicitly keeps the feature at suspension only
  - Jira suggests bulk action, while PD-117 keeps MVP single-item only
- Provisional resolution:
  - follow PD-117 as the higher-priority source
  - keep manager access, deletion, and bulk behavior out of scope

## 12. Ambiguity log references
- none required for this run

## 13. Readiness for specification
- Ready for spec: Yes
- Stable enough:
  - scope is fixed by the PD
  - actors and permissions are explicit
  - post-suspension discoverability is explicit
- Blocking items:
  - none

## 14. Product Quality Gate
- Decision: PASS
- Reason:
  - the higher-priority PD resolves the scope and permission conflict cleanly
  - the feature boundary is stable enough for downstream work

## 15. Handoff to sdd-spec-writer
### May assume
- suspension is not deletion
- only workspace owners may suspend a member
- suspended members leave the active member list
- suspended members remain visible in a dedicated suspended members view for workspace owners
- the action requires explicit confirmation

### Must not invent
- deletion behavior
- bulk suspension behavior
- restore behavior
- manager permission to suspend
- a broader visibility model for suspended members

### Still needs to specify
- scenario structure and error wording
- failure and permission cases
- precise refusal behavior on direct access attempts by non-owners
