# Red Flags

This document defines the warning signs that indicate the task is no longer a straightforward specification-writing task.

The skill should not blindly continue whenever a request looks like a `.feature` request.
Some requests are actually:
- underdefined product discovery
- unresolved workflow design
- hidden scope change
- sensitive permission design
- architecture decision work
- governance-sensitive change

The purpose of these red flags is to help the skill stay useful without stepping outside its role.

---

# Core rule

When one or more red flags appear, the skill must not continue as if the request were a normal spec-writing task.

Instead, it must choose one of these responses:

1. continue normally if the red flag is weak and safely containable
2. continue conservatively and mark `Needs validation`
3. create or update an ambiguity trace
4. stop treating the request as a standard spec task and surface what is missing or what type of upstream decision is required

---

# Category 1 - Discovery red flags

These signals suggest the need is still too early or too fuzzy for proper specification.

## Red flags

- the user goal is not clearly stated
- several different product directions are still plausible
- the core actor is unclear
- the expected outcome is unclear
- the workflow itself is not yet defined
- the task asks what the feature "should" do rather than what it "must" do
- the request contains mostly questions, options, or brainstorming
- the request depends on product prioritization that is not yet decided

## Expected behavior

- do not pretend the feature is already spec-ready
- do not fabricate a stable contract
- explain that the request is still underdefined for specification
- continue only with a conservative partial contract if a stable subset clearly exists
- otherwise surface the missing framing

---

# Category 2 - Product decision red flags

These signals suggest that the skill would need to make a business decision rather than write a contract.

## Red flags

- two or more plausible business rules exist
- acceptance outcome depends on a decision not yet documented
- scope boundaries are still actively negotiable
- an excluded variant may need to become supported
- a current Jira request implies a product change not reflected in validated sources
- the request would create a new business rule rather than formalize an existing one

## Expected behavior

- do not choose the preferred business option silently
- write only what is grounded
- mark `Needs validation`
- trace ambiguity when the decision materially affects the contract
- preserve validated scope unless explicitly superseded

---

# Category 3 - UX and workflow red flags

These signals suggest the user flow or interaction design is not settled enough to support reliable specification.

## Red flags

- multiple user flows are possible and not validated
- the trigger action depends on UI behavior not yet designed
- the workflow step order is unclear
- the meaning of confirm / cancel / retry / back / submit is not stabilized
- status messaging, review step, or approval flow changes expected behavior materially
- state transitions depend on UX choices that remain open

## Expected behavior

- do not lock in UX-dependent behavior as if it were decided
- keep the behavioral contract limited to what is clearly validated
- mark validation points for open workflow decisions
- escalate conceptually to upstream UX/workflow design when needed

---

# Category 4 - Permission and access-control red flags

These signals are especially sensitive and should be treated with caution.

## Red flags

- it is unclear who is allowed to perform the action
- the action is admin-like, destructive, financial, or sensitive
- the request implies broader visibility than existing sources support
- actor roles are inconsistently named across sources
- the same action appears to behave differently by role, but the distinction is not documented
- permission depends on tenant, workspace, ownership, or hierarchy rules that are not explicit

## Expected behavior

- do not infer broad access
- use the narrowest safe interpretation only when conservative handling is acceptable
- mark validation for meaningful or sensitive permission gaps
- create an ambiguity trace when the permission uncertainty materially affects the contract

---

# Category 5 - State-transition red flags

These signals suggest the workflow lifecycle is not sufficiently stable.

## Red flags

- allowed transitions are unclear
- reverse transitions are implied but not documented
- restore, reopen, retry, resubmit, or rollback behavior is assumed but not specified
- current state names exist but their behavioral meaning is unclear
- a requested action changes lifecycle meaning in a structural way
- the same entity appears to follow different state rules in different sources

## Expected behavior

- do not invent missing transitions
- preserve only documented transitions
- require validation when lifecycle meaning changes materially

---

# Category 6 - Scope-change red flags

These signals suggest the task is no longer a simple revision or refinement.

## Red flags

- a single-item feature starts to imply batch support
- a read flow starts to imply edit or delete support
- archive starts to imply restore
- export starts to imply scheduled export
- detail-page action starts to imply bulk action
- a revision request changes supported roles, states, or acceptance outcomes
- "small clarification" would materially expand the feature

## Expected behavior

- do not treat scope expansion as editorial cleanup
- surface the scope change explicitly
- mark `Needs validation`
- keep unsupported extensions out of scope unless validated

---

# Category 7 - Source conflict red flags

These signals indicate the skill may be tempted to normalize contradictions.

## Red flags

- Jira conflicts with a validated `.feature`
- code conflicts with documented intent
- two product sources appear to imply different behaviors
- a more recent source exists but applicability is unclear
- the current `.feature` reflects legacy behavior but product intent appears to have evolved
- terminology mismatch changes interpretation

## Expected behavior

- apply source priority
- do not merge contradictions silently
- surface materially important conflicts
- require validation when higher-level interpretation is still uncertain

---

# Category 8 - Architecture red flags

These signals suggest the task needs an architecture decision rather than pure spec writing.

## Red flags

- the expected behavior depends on unresolved module boundaries
- the action implies a cross-context responsibility that is not assigned
- a new workflow depends on eventing, async processing, or integration pattern not yet decided
- data ownership or source-of-truth system is unclear
- the requested behavior implies a structural persistence or synchronization strategy
- the spec would force a technical decision that should be handled by ADR

## Expected behavior

- do not embed architecture decisions inside the spec as if they were functional facts
- keep the contract at behavioral level
- mark the architectural dependency
- escalate conceptually to architecture decision work when needed

---

# Category 9 - Sensitive-data and compliance red flags

These signals require especially strong discipline.

## Red flags

- the behavior touches personal data, financial data, health data, regulated data, or audit-critical data
- visibility of sensitive information is unclear
- retention or deletion behavior is unclear
- compliance or consent behavior is implied but not documented
- export, download, restore, or share actions affect sensitive data
- logging, traceability, or masking expectations are unclear and materially relevant

## Expected behavior

- do not infer permissive behavior
- do not guess retention or deletion semantics
- mark validation as required
- trace ambiguity when the contract would otherwise become unsafe

---

# Category 10 - Revision-specific red flags

These signals indicate that revise mode may be turning into a hidden product rewrite.

## Red flags

- "clean up the feature" would change acceptance meaning
- the current `.feature` is weak, but the missing rules are not grounded in higher-priority sources
- the new ticket implies a broader feature than the current contract
- code behavior differs from the current `.feature`
- the current `.feature` contains implicit constraints that are at risk of being removed
- the revision would change role behavior, state rules, or supported variants

## Expected behavior

- classify the revision properly
- preserve validated intent unless explicitly superseded
- do not hide contract changes as editing
- surface meaningful changes explicitly
- require validation for scope-changing revision

---

# Severity guide

## Weak red flag
The issue is noticeable but safely containable.

Expected behavior:
- continue
- stay conservative
- optionally note assumption

## Moderate red flag
The issue may change interpretation or downstream implementation.

Expected behavior:
- continue carefully
- add `Needs validation` or companion note
- trace ambiguity when useful

## Strong red flag
The issue changes product meaning, permissions, scope, safety, or architecture.

Expected behavior:
- do not continue as a normal spec task
- provide only a grounded conservative subset if possible
- explicitly surface the blocking decision or missing input
- require validation

---

# Escalation rule

When red flags indicate the request belongs to another type of work, the skill should say so clearly without overstepping.

Typical conceptual redirects:

- discovery/problem framing -> upstream product framing work
- unresolved workflow/interaction design -> upstream workflow/UX design work
- unresolved technical responsibility or system behavior dependency -> architecture decision work
- sensitive permission or compliance rule -> validation required before final contract

The skill should remain helpful, but should not fake certainty.

---

# Anti-patterns

Do not:

- continue confidently through obvious uncertainty
- turn discovery into fake specification
- hide scope change inside revision
- infer sensitive permissions for convenience
- let current code silently redefine the contract
- choose a product direction because it seems likely
- embed architecture choices in functional wording
- suppress a strong red flag just to keep output tidy

---

# Final rule

A robust spec writer is not the one that always produces a full `.feature`.

A robust spec writer is the one that knows when a request is truly spec-ready, when it can proceed conservatively, and when it must make the unresolved points visible.
