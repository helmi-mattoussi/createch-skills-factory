# Product Framing Dossier

## 1. Header
- Topic: Resend pending workspace invitations in the current web application
- Sources:
  - `validations/skills/brief-to-product-docs/fixtures/tc-05-resend-invite-scope-drift.md`
- Status: PASS WITH EXPLICIT FOLLOW-UPS
- Owner: Product review pending

## 2. Business objective
- Objective: Allow authorized workspace staff to resend a pending invitation without recreating it manually.
- Expected value:
  - reduce onboarding friction when emails are not received
  - avoid duplicate invitation creation
  - keep invitation recovery inside the existing invitation flow

## 3. Problem to solve
- Current pain/problem:
  - when an invited person does not receive the email, the team lacks a simple recovery action
  - owners may need to recreate invitations manually to continue onboarding
- Why it matters now:
  - this slows onboarding for invited members
  - the recovery action is narrower and safer than broader invitation editing

## 4. Scope
### In scope
- resend one pending workspace invitation
- keep the action inside the existing invitation management area
- allow the resend action only for actors already authorized to manage invitations

### Out of scope
- editing the invited email
- cancelling invitations
- bulk resend
- API design
- detailed screen design
- `.feature` writing
- implementation task breakdown

## 5. Actors
- Primary actors:
  - workspace owner
  - workspace manager
- Secondary actors:
  - invited person as the recipient of the resent invitation

## 6. Known business rules
- R1: Only pending invitations are eligible for resend.
- R2: The capability is intended for actors already authorized to manage invitations.
- R3: Recreating the invitation manually should not be required for this recovery path.

## 7. Assumptions
- A1: Workspace owners and workspace managers are already the validated actors for invitation management in the existing product.
- A2: Resend does not change the invited email or invitation identity.

## 8. Open questions
- Q1: Should there be any cooldown or duplicate-send protection in MVP?
- Q2: Does the product want the user to see the last resend timestamp in MVP or is that out of scope?

## 9. Points to arbitrate / Needs validation
- D1: Confirm whether invitation management permissions are already validated for both workspace owners and workspace managers, or whether this brief is assuming that existing permission boundary.

## 10. Risks / vigilance points
- resend must not silently expand into invitation editing
- resend must not silently become bulk resend
- downstream work must not absorb the request for API design, screen design, `.feature`, or implementation planning into this framing step

## 11. Source-of-truth and conflicts
- Sources used:
  - raw request in `tc-05-resend-invite-scope-drift.md`
- Conflicts detected:
  - none on the product goal itself
  - the request mixes framing with downstream asks for API, UX, `.feature`, and task planning
- Provisional resolution:
  - keep only product framing here
  - leave API, UX design, specification, and implementation planning to downstream steps

## 12. Ambiguity log references
- none required for this run

## 13. Readiness for specification
- Ready for spec: Partial
- Stable enough:
  - business objective is clear
  - first-level scope is narrow and stable
  - the main eligibility rule is visible
- Blocking items:
  - confirm whether both workspace owners and workspace managers are already validated invitation-management actors

## 14. Product Quality Gate
- Decision: PASS WITH EXPLICIT FOLLOW-UPS
- Reason:
  - the business problem and first-level scope are clear enough for controlled downstream work
  - the request contains scope-drift pressure, but that pressure is outside this skill's role and has been kept out of the framing output
- Follow-ups:
  - validate the exact permission boundary if it is not already established upstream
  - route UX design to `workflow-ui-ux-advisor`
  - route behavioral specification to `sdd-spec-writer`
  - route API and implementation decisions to downstream technical skills

## 15. Handoff to sdd-spec-writer
### May assume
- the feature is about resending one pending invitation, not recreating it manually
- only pending invitations are in scope for resend
- editing invitation details is out of scope
- cancelling invitations is out of scope
- bulk resend is out of scope

### Must not invent
- invitation editing behavior
- cancellation behavior
- bulk resend behavior
- API structure
- detailed screen structure
- implementation task breakdown

### Still needs to specify
- scenario wording
- permission and refusal cases
- whether resend cooldown or duplicate-send protection is part of MVP
