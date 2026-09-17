# Ambiguity Policy

This document defines how the skill must behave when UX decisions cannot be made without additional product, architecture, or permission information.

The goal is to keep UX design moving without silently inventing product behavior.

A good UX designer is not blocked by every missing detail.
A good UX designer is also not allowed to hide structural ambiguity behind polished-looking wireframes.

---

# Core rule

When UX ambiguity exists:

1. do not silently invent product-level decisions
2. prefer a conservative UX interpretation when safe
3. trace ambiguity when it materially affects the behavioral contract
4. require validation when the uncertainty affects product scope, permissions, data visibility, or destructive actions

---

# UX ambiguity levels

## Level 1 — Low-risk ambiguity

A minor UX uncertainty that does not materially change product intent, permissions, or scope.

Examples:
- label wording can be normalized using project vocabulary
- obvious secondary action is implied by an already explicit primary action
- a common UX convention applies and does not require product decision

Expected behavior:
- resolve directly using the most common safe UX convention
- do not create an ambiguity trace
- do not block design

---

## Level 2 — Medium-risk ambiguity

A UX uncertainty that affects interpretation of interaction flow but can be handled conservatively.

Examples:
- fallback UX behavior on error is not specified in framing (but obvious safe behavior exists)
- a non-sensitive secondary action is implied but not confirmed
- a scope boundary for the UX should be made explicit to avoid drift

Expected behavior:
- choose a conservative UX interpretation
- make the assumption explicit in the Assumptions section
- add the assumption to the Needs validation section if it could be disputed
- create an ambiguity trace if the issue is likely to matter for specification

---

## Level 3 — High-risk ambiguity

A UX uncertainty that materially affects the product contract and cannot be safely absorbed.

Examples:
- two plausible UX directions exist with different product implications
- permission model for a visible action is unclear
- data visible on a screen depends on an unresolved actor definition
- a destructive or irreversible action has no confirmed UX treatment
- the UX flow depends on an architecture decision not yet made
- two product sources imply different screen or navigation structures

Expected behavior:
- do not silently resolve
- design only the UX subset that is safe and grounded
- mark the unresolved point explicitly as Needs validation
- create an ambiguity trace when the uncertainty will materially affect sdd-spec-writer
- separate clearly: what is designed, what is assumed conservatively, what requires validation

---

# Conservative UX interpretation rule

When a conservative UX interpretation is allowed, it must follow these principles:

- do not broaden access or visibility
- do not add screens or interactions not in the framing scope
- do not assume destructive actions are safe to design without validation
- do not assume complex flow states without explicit support
- do not present a guessed UX direction as a validated design decision

Good conservative examples:
- show a confirmation step for irreversible actions
- keep unsupported secondary features out of scope
- display the most restrictive actor's view when permission is unclear
- design for single-item actions rather than assuming batch support

Bad conservative examples:
- showing sensitive data to all actors because it is probably intended
- designing a rich filtering interface when only basic list was in scope
- assuming a dashboard exists because it seems useful
- adding notification behaviors because they feel natural for the flow

---

# When the skill may resolve ambiguity alone

The skill may resolve ambiguity alone when all of the following are true:
- the UX interpretation is low-risk
- it follows a safe and widely accepted UX convention
- it does not change product intent, permissions, or scope
- it can be stated explicitly as an assumption
- it does not affect sensitive or destructive actions

If one of these conditions is not met, the ambiguity must be surfaced.

---

# When ambiguity must be traced

Create an ambiguity trace when the uncertainty materially affects:
- the user journey (alternative paths exist)
- screen structure (which screens exist and what is on them)
- UI states (what state model is used)
- navigation flow (how screens connect)
- form logic (what fields are required and what validation applies)
- actor visibility (who sees what)
- permission for an action visible in the UX
- downstream specification by sdd-spec-writer

---

# When validation is mandatory

Mark validation as mandatory when the unresolved point affects:
- which actor can perform a visible action
- visibility of sensitive or personal data
- a destructive or irreversible action's UX treatment
- a UX direction with meaningful product scope implications
- a navigation choice that implies a product capability not yet validated
- an architecture-level dependency that changes the feasible UX pattern

---

# Required output behavior when ambiguity exists

When ambiguity exists, clearly distinguish:

## 1. What is designed
UX decisions grounded in validated framing and sources.

## 2. What is assumed conservatively
Temporary UX choices used to keep the design useful.

## 3. What remains unresolved
UX decisions that require product, architecture, or permission validation.

This separation must be visible in the Assumptions and Needs validation sections.

---

# Ambiguity trace format

When a trace is needed:

```markdown
UX Ambiguity
- <short statement of what is unclear in the UX design>

Observed sources
- <source 1>
- <source 2>

Conservative UX handling
- <what was designed, if anything>

Risk for specification
- <why this matters for sdd-spec-writer>

Needs validation
- <what must be decided>
```

---

# Final rule

A UX Design Note that looks polished but hides unresolved product choices is not an asset.

It is a source of silent invention downstream.

When in doubt: design conservatively, surface clearly, and let the humans decide.
