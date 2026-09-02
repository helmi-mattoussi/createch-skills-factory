# Ambiguity Policy

This document defines how the skill must behave when source inputs are incomplete, unclear, conflicting, or partially missing.

The goal is to preserve delivery speed **without silently inventing important business behavior**.

A good spec writer is not blocked by every uncertainty.
A good spec writer is also not allowed to hide structural ambiguity behind confident wording.

---

# Core rule

When ambiguity exists:

1. do not silently invent structural behavior
2. prefer a conservative interpretation when safe
3. trace ambiguity when it materially affects the contract
4. require validation when the uncertainty affects product, permissions, security, sensitive data, or architecture

---

# Definition of ambiguity

An ambiguity exists when at least one of the following is true:

- the expected behavior is not fully specified
- two sources imply different behaviors
- a rule can be interpreted in more than one plausible way
- actor permissions are unclear
- allowed state transitions are unclear
- validation or error behavior is unclear
- scope boundaries are unclear
- wording is too vague to support a reliable implementation

Not all ambiguities require the same treatment.

---

# Ambiguity levels

## Level 1 - Low-risk ambiguity

This is a minor uncertainty that does not materially change business intent, permissions, scope, or safety.

Examples:
- wording can be normalized using known glossary terms
- an obvious actor label can be clarified from context
- a trivial edge case is implied by an already explicit rule
- formatting or section structure is missing but meaning is stable

Expected behavior:
- resolve directly
- do not create an ambiguity trace
- do not block drafting

---

## Level 2 - Medium-risk ambiguity

This is an uncertainty that affects interpretation of behavior, but can be handled conservatively without introducing major product or governance risk.

Examples:
- a fallback behavior is not explicitly stated
- an edge case matters but the safest behavior is obvious
- a non-sensitive permission nuance is missing
- an out-of-scope boundary should be made explicit to avoid drift

Expected behavior:
- choose a conservative interpretation
- make the assumption explicit
- add a short companion note when useful
- create an ambiguity trace if the issue is likely to matter later

---

## Level 3 - High-risk ambiguity

This is an uncertainty that materially affects the business contract and cannot be safely absorbed without visible escalation.

Examples:
- two plausible business outcomes exist
- permission model is unclear for a sensitive action
- destructive behavior is possible but not explicitly defined
- source-of-truth conflict changes behavior or scope
- personal, financial, legal, compliance, or security-sensitive data behavior is unclear
- a UX-dependent decision materially changes the contract
- the needed behavior implies a structural architecture decision

Expected behavior:
- do not silently resolve
- provide only a conservative partial contract when possible
- explicitly mark `Needs validation`
- create an ambiguity trace
- clearly separate known facts, conservative assumption, and unresolved decision

---

# Conservative interpretation rule

When a conservative interpretation is allowed, it must follow these principles:

- do not broaden access
- do not expand scope
- do not introduce destructive actions
- do not assume irreversible state transitions
- do not assume hidden automation
- do not invent exceptions to rules
- do not present a guessed rule as validated fact

Good conservative examples:
- refuse action when permission is unclear
- keep unsupported variant out of scope
- preserve current documented state rules
- avoid assuming batch support from a single-item flow

Bad conservative examples:
- allowing access because it is probably intended
- assuming deletion when archive is the only documented behavior
- inventing notification behavior because it seems useful
- inferring cross-role visibility without explicit support

---

# When the skill may resolve ambiguity alone

The skill may resolve ambiguity alone only when all of the following are true:

- the interpretation is low-risk or safely conservative
- it does not change product intent in a structural way
- it does not weaken security or permissions
- it does not introduce sensitive data exposure
- it does not require architecture-level decision making
- it can be stated explicitly if needed

If one of these conditions is not met, the ambiguity must be surfaced.

---

# When ambiguity must be traced

Create or update an ambiguity trace when uncertainty materially affects any of the following:

- business behavior
- acceptance outcome
- permissions or visibility
- validation rules
- state transitions
- important edge cases
- scope boundaries
- consistency across sources
- implementation assumptions likely to affect downstream builders

Do not create ambiguity traces for trivial editorial cleanup.

---

# When validation is mandatory

Mark validation as mandatory when the unresolved point affects:

- structural product behavior
- business rule creation or modification
- access control on important actions
- destructive or irreversible actions
- regulated, personal, financial, or security-sensitive data
- major UX-dependent behavior
- compliance-sensitive flows
- source-of-truth conflict on expected outcomes
- architecture-level decisions that should be covered by ADR

In these cases, the skill may still draft a conservative version, but must not present the unresolved point as settled.

---

# Required output behavior when ambiguity exists

When ambiguity exists, the skill must clearly distinguish:

## 1. What is known
Facts grounded in available validated sources.

## 2. What is assumed conservatively
A temporary interpretation used to keep the spec useful.

## 3. What remains unresolved
Points that require validation, clarification, or upstream decision.

This separation must remain visible in the output or companion note.

---

# Companion note usage

Use a short companion note when ambiguity affects the usefulness of the `.feature` but does not justify blocking the whole draft.

Recommended sections:

```md
Assumptions
- <explicit conservative assumption>

Open questions
- <clear unresolved question>

Needs validation
- <decision that must be confirmed>

Out of scope
- <boundary added to avoid over-implementation>
```

Keep the note short and operational.

Do not create long analytical commentary.

---

# Ambiguity trace format

When an ambiguity trace is needed, keep it short and actionable.

Recommended structure:

```md
Ambiguity
- <short statement of what is unclear>

Observed sources
- <source 1>
- <source 2>

Conservative handling
- <what interpretation was used, if any>

Risk
- <why this matters>

Needs validation
- <what must be decided>
```

The trace should help a reviewer resolve the issue quickly.

---

# Source conflict rule

When two sources conflict:

1. apply the project's source-of-truth hierarchy
2. do not merge conflicting intentions silently
3. document the conflict if it changes meaning
4. require validation if the conflict is structurally important

Examples:
- if Jira conflicts with a more recent PD, follow the PD
- if existing code conflicts with a validated `.feature`, follow the validated `.feature`
- if two product sources appear equally authoritative and imply different behaviors, surface the issue and require validation

---

# Scope ambiguity rule

When scope is unclear:

- keep only clearly supported behavior in scope
- move plausible but unsupported extensions to `Out of scope`
- avoid silently adding convenience variants
- explicitly mention excluded variants when builders might otherwise infer them

Examples:
- single-item action does not imply batch support
- archive does not imply restore
- export does not imply scheduled export
- detail-page action does not imply bulk list action

---

# Permission ambiguity rule

When permissions are unclear:

- do not assume broad access
- use the narrowest safe interpretation
- mark validation if the action is meaningful or sensitive
- explicitly document the uncertainty

This is especially important for:
- admin actions
- visibility of sensitive information
- financial or compliance actions
- destructive operations

---

# State-transition ambiguity rule

When allowed state transitions are unclear:

- do not assume a transition is allowed
- preserve only documented transitions
- reject or mark unclear transitions conservatively
- require validation when the transition changes workflow meaning

Examples:
- do not assume archived can return to active unless documented
- do not assume rejected can be edited and resubmitted unless documented

---

# Anti-patterns

Do not:

- hide ambiguity behind polished wording
- guess the preferred business option and present it as fact
- widen permissions because it feels convenient
- use current code behavior as proof when higher-level documentation disagrees
- stop on every small uncertainty
- produce a long analysis instead of a usable contract

---

# Final rule

Speed is valuable, but silent invention is dangerous.

When in doubt, the skill should remain useful by drafting conservatively, while making unresolved structural points visible and traceable.
