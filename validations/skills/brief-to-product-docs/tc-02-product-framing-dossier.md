# Product Framing Dossier

## 1. Header
- Topic: Temporary alternative to subscription cancellation
- Sources:
  - `validations/skills/brief-to-product-docs/fixtures/tc-02-ambiguous-subscription-pause-brief.md`
- Status: NEEDS ARBITRATION BEFORE SPECIFICATION
- Owner: Product arbitration required

## 2. Business objective
- Objective: Offer a temporary alternative to cancellation for customers who need to stop their subscription for a period of time.
- Expected value:
  - reduce preventable churn
  - give internal staff a safer alternative than cancellation
  - preserve the possibility of returning the customer to normal subscription status later

## 3. Problem to solve
- Current pain/problem:
  - customers who only need a temporary stop may cancel entirely
  - the team lacks a stable business definition for a temporary stop action
- Why it matters now:
  - the business sees retention value in a temporary alternative
  - the current request is strategically ambiguous and would force downstream invention if left unresolved

## 4. Scope
### In scope
- define the business framing for a temporary alternative to subscription cancellation
- identify the stable actor and first-version perimeter
- surface the unresolved decision on what `pause` actually means in MVP

### Out of scope
- redesign of the full cancellation flow
- self-service customer pause flow
- plan switching
- billing proration redesign
- marketing win-back automation

## 5. Actors
- Primary actors:
  - internal staff handling subscription management
- Secondary actors:
  - subscribed customer affected by the temporary stop

## 6. Known business rules
- R1: The requested capability is intended as an alternative to full cancellation.
- R2: The first version should stay narrow.
- R3: The action is intended for internal staff in the current request, not for a full customer self-service flow.

## 7. Assumptions
- A1: None added deliberately because the competing directions affect core business meaning.

## 8. Open questions
- Q1: Is MVP pause primarily a billing behavior, an access behavior, or a combination of both?
- Q2: If billing changes, when does that change take effect?
- Q3: If access changes, when does that change take effect?
- Q4: What should the customer-visible status communicate in MVP?

## 9. Points to arbitrate / Needs validation
- D1: Direction A - `pause` means a commercial pause centered on billing relief and retention.
- D2: Direction B - `pause` means an access freeze centered on immediate product blocking.
- D3: If MVP combines both billing and access changes, define which one is primary and what exact timing rules apply.

## 10. Risks / vigilance points
- downstream work must not silently choose a billing-first definition
- downstream work must not silently choose an access-first definition
- the term `pause` is too broad to use safely in specification without arbitration

## 11. Source-of-truth and conflicts
- Sources used:
  - raw stakeholder brief in `tc-02-ambiguous-subscription-pause-brief.md`
- Conflicts detected:
  - sales and support imply different meanings of `pause`
- Provisional resolution:
  - no resolution applied at framing level
  - preserve only the grounded subset and escalate the business meaning for arbitration

## 12. Ambiguity log references
- `validations/skills/brief-to-product-docs/tc-02-subscription-pause-ambiguity.md`

## 13. Readiness for specification
- Ready for spec: No
- Stable enough:
  - the retention-oriented objective is clear
  - the request is narrower than a full cancellation redesign
- Blocking items:
  - the core meaning of `pause` is unresolved
  - billing and access semantics are both unsafe for downstream invention

## 14. Product Quality Gate
- Decision: HOLD
- Reason:
  - the request contains at least two plausible strategic interpretations
  - any downstream specification would have to invent billing or access behavior
- Follow-ups:
  - arbitrate the MVP meaning of `pause`
  - publish the validated direction before sending this subject to UX or specification

## 15. Handoff to sdd-spec-writer
### May assume
- the business wants a temporary alternative to cancellation
- the first version should stay narrow
- self-service customer flow is out of scope for the current request

### Must not invent
- whether pause is defined first by billing behavior or access behavior
- whether billing changes immediately or later
- whether access changes immediately or later
- customer-visible status semantics for the paused subscription

### Still needs to specify
- none until product arbitration resolves the core pause meaning
