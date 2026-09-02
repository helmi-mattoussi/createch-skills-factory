# Source Priority

This document defines the order of truth the skill must follow when drafting or revising `.feature` specifications.

The objective is to prevent the skill from drifting toward convenience, legacy behavior, or undocumented assumptions.

---

# Source-of-truth order

Always use this priority order:

1. applicable and most recent `PD-*` and `ADR-*`
2. validated `.feature` files
3. Jira ticket
4. existing code

Higher-priority sources override lower-priority sources.

---

# Interpretation rules

## 1. Product and architecture decisions come first

`PD-*` and `ADR-*` define the authoritative business and technical intent when applicable.

If a lower-priority source conflicts with them, follow the `PD-*` or `ADR-*`.

Do not preserve lower-priority behavior only because it already exists in code or ticket wording.

---

## 2. Validated `.feature` files come before Jira

A validated `.feature` is a stronger behavioral contract than a Jira ticket.

If Jira wording is less precise, older, or inconsistent with a validated `.feature`, follow the validated `.feature`.

If Jira implies a scope change, do not silently overwrite the existing contract. Surface the change explicitly.

---

## 3. Jira is an input, not final truth

Use Jira to understand:
- feature intent
- requested change
- delivery context
- examples or constraints

Do not treat Jira as authoritative over validated decisions or validated specs.

Jira tickets are often incomplete, compressed, or partially outdated.

---

## 4. Existing code is last

Existing code is a useful signal for:
- current behavior
- implementation constraints
- legacy drift
- missing documentation clues

But code is not the primary truth when higher-level validated sources exist.

Do not reverse-engineer the product contract from code if:
- a `PD-*` says otherwise
- an `ADR-*` says otherwise
- a validated `.feature` says otherwise

---

# Conflict handling rules

When two sources conflict:

1. identify the higher-priority source
2. follow that source
3. do not silently merge contradictory meanings
4. flag the conflict when it changes behavior, permissions, state transitions, or scope
5. mark validation required if the conflict is structurally important

---

# Recency rule

Within the same source type:
- prefer the most recent applicable source
- prefer the source that is clearly in scope for the current feature
- do not prefer a newer unrelated document over an older directly applicable one

Recency matters only after applicability.

---

# Applicability rule

A source should influence the spec only if it is actually relevant to the feature being written or revised.

Do not import unrelated rules from:
- another module
- another actor type
- another workflow
- another business context

Prefer narrow relevance over broad analogy.

---

# Missing-source rule

If a higher-priority source is absent:
- use the next available source
- remain conservative
- do not pretend the contract is fully validated if it is not
- surface important uncertainty when needed

---

# Drift rule

If existing code or Jira suggests behavior drift from validated sources:
- keep the validated source as the contract baseline
- surface the drift explicitly
- do not normalize the drift into the new spec without validation

---

# Final rule

The skill must optimize for documented intent, not implementation convenience.

When in doubt:
- follow the highest applicable validated source
- stay conservative
- make structural uncertainty visible
