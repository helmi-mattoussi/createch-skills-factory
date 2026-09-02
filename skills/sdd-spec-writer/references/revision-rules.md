# Revision Rules

This document defines how the skill must behave when revising an existing `.feature`.

Revision is a high-risk activity because the skill can accidentally:
- rewrite validated intent
- widen scope
- normalize drift from code or Jira
- remove important behavioral detail while "cleaning up"
- introduce unvalidated product changes

The objective of revision is not to rewrite for elegance.
The objective is to improve contract quality while preserving validated intent.

---

# Core rule

In revise mode:

1. preserve validated intent by default
2. improve clarity, completeness, and structure
3. do not widen scope unless a higher-priority source explicitly requires it
4. clearly surface meaningful behavioral changes
5. never disguise a product change as editorial cleanup

---

# What revision is allowed to do

Revision may:

- clarify vague wording
- normalize terminology to glossary-approved terms
- restructure the feature for readability
- make permissions explicit when already implied by validated sources
- add missing error cases when they are clearly required by existing documented rules
- add missing edge cases when they are obvious consequences of documented behavior
- separate mixed behaviors into cleaner scenarios
- align the `.feature` with higher-priority validated sources
- add short scope boundaries when needed to prevent implementation drift

These improvements are allowed only if they do not silently change the intended contract.

---

# What revision must not do

Revision must not:

- invent new business rules
- introduce new supported variants without source support
- widen permissions
- change acceptance outcomes without explicit justification
- replace a validated behavior with current code behavior for convenience
- remove previously validated constraints because they seem unnecessary
- merge distinct behaviors into a vague generalized statement
- reinterpret a business rule just to make implementation easier
- convert an unresolved ambiguity into a fake certainty

---

# Revision priority order

When revising an existing `.feature`, use this priority order:

1. applicable and most recent `PD-*` and `ADR-*`
2. validated current `.feature`
3. Jira ticket
4. existing code

The current `.feature` is not untouchable.
But it remains the default behavioral baseline unless a higher-priority source requires change.

---

# Types of revision

## Type 1 - Editorial cleanup

This is low-risk revision.

Examples:
- improve wording
- normalize vocabulary
- improve scenario titles
- make state wording consistent
- reorder sections for clarity
- split overloaded scenario into smaller scenarios without changing behavior

Expected behavior:
- revise directly
- no special escalation needed
- no ambiguity trace unless another issue appears

---

## Type 2 - Contract completion

This is medium-risk revision.

Examples:
- add missing permission statement already supported by sources
- add explicit validation behavior implied by documented rule
- add obvious edge case required for contract completeness
- make out-of-scope boundaries explicit to prevent drift

Expected behavior:
- revise carefully
- keep additions conservative
- mention assumptions or companion note when useful
- trace ambiguity if uncertainty remains materially relevant

---

## Type 3 - Contract correction

This is higher-risk revision.

Examples:
- current `.feature` conflicts with a more recent PD
- current `.feature` conflicts with an ADR-applicable constraint
- current `.feature` omits a documented restriction that changes expected behavior
- Jira suggests a change that would alter the current contract

Expected behavior:
- revise according to the higher-priority source
- explicitly surface the change
- do not present the change as mere cleanup
- mark validation when business impact is meaningful

---

## Type 4 - Scope-changing revision

This is not ordinary revision.

Examples:
- adding batch support to a single-item feature
- adding restore flow to an archive feature
- changing who can perform the action
- changing business outcomes or workflow transitions
- introducing new variants not previously validated

Expected behavior:
- do not silently apply as standard revision
- treat as explicit contract change
- mark `Needs validation`
- surface the scope change clearly
- redirect conceptually to upstream product/spec decision if needed

---

# Revision workflow

## 1. Identify the revision baseline

Before changing anything, identify:
- what behavior the current `.feature` already commits to
- what constraints are already validated
- what terminology is already stable
- where the current feature is weak: vagueness, incompleteness, inconsistency, drift

Do not begin revision by rewriting blindly.

---

## 2. Classify each intended change

For each change, determine whether it is:

- editorial cleanup
- contract completion
- contract correction
- scope-changing revision

Do not mix these categories invisibly.

If a change is not clearly editorial, treat it with higher caution.

---

## 3. Check every meaningful change against source hierarchy

Before changing behavior, permissions, state transitions, or scope:
- check applicable `PD-*`
- check applicable `ADR-*`
- check current validated `.feature`
- check Jira only after the above
- use code only as a secondary signal

If the change is not grounded, do not silently apply it.

---

## 4. Preserve validated intent unless explicitly superseded

If the current `.feature` is consistent with higher-priority sources:
- preserve its intent
- improve structure and completeness
- do not reinterpret it creatively

Revision is not an excuse to redesign.

---

## 5. Surface meaningful changes explicitly

A revision must make meaningful changes visible when they affect:
- behavior
- permissions
- state transitions
- scope boundaries
- acceptance conditions
- important edge cases

Do not hide these changes inside polished rewritten prose.

When useful, include a short note such as:

```md
Meaningful changes
- permission rule made explicit for archive action
- draft state restriction added from PD-014
- batch archive kept out of scope to preserve current validated intent
```

Keep this note short and operational.

---

# Preservation rule

When in doubt, preserve:
- existing validated behavior
- existing explicit constraint
- existing scope boundary
- existing actor restriction

Do not remove a constraint unless a higher-priority source clearly invalidates it.

---

# Drift handling rule

If Jira or current code suggests behavior that differs from the validated `.feature`:

- do not normalize the drift automatically
- identify whether this is:
  - desired product evolution
  - undocumented implementation drift
  - ticket-level shortcut wording
- preserve current validated contract unless a higher-priority source supports the change
- mark validation when the change is real but not yet fully grounded

---

# Missing-detail rule

If the existing `.feature` is too thin to support implementation:

- complete only what is justified by available sources
- use conservative completion
- separate assumptions from validated facts
- trace ambiguity if the missing detail materially affects downstream implementation

Do not "finish the feature from intuition".

---

# Permission revision rule

Permissions are especially sensitive during revision.

Do not:
- broaden access implicitly
- replace explicit role checks with vague actor language
- assume admin access where only user access is mentioned
- infer cross-scope visibility without support

If permission behavior is incomplete but important:
- keep the narrowest safe interpretation
- mark validation if needed
- document the gap explicitly

---

# State-transition revision rule

When revising workflow behavior:

- preserve documented state transitions
- do not add reverse transitions unless supported
- do not assume retry, reopen, restore, or resubmit behavior unless documented
- make blocked transitions explicit when needed

A workflow revision can silently become a product redesign. Avoid that.

---

# Revision anti-patterns

Do not:

- rewrite everything because the original style is weak
- collapse precise rules into generic prose
- "modernize" the feature by guessing the intended product direction
- align the spec to current code when code drift is possible
- treat Jira wording as enough reason to overwrite a validated contract
- remove out-of-scope boundaries because they feel redundant
- change permissions silently while cleaning wording
- present a scope change as a clarification

---

# Final rule

A good revision makes the contract clearer and safer.

It does not quietly produce a different product.
