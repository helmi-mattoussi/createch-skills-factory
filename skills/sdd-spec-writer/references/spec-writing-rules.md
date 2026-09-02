# Spec Writing Rules

This document defines the writing discipline for `.feature` specifications.

The objective is simple:
A `.feature` must describe **observable, testable behavior** in a way that builders can implement without inventing missing product rules.

A good specification reduces interpretation and ambiguity.

---

# Core principle

A `.feature` describes **what the system must do**, not how it will be implemented.

It must focus on:

- behavior
- rules
- permissions
- state transitions
- validation conditions
- observable outcomes

It must not include:

- technical architecture
- framework structure
- class design
- API schema details
- database schema details

Those belong to architecture or implementation.

---

# Behavioral focus

All specifications must describe **observable system behavior**.

Good specification:

- describes actions and results
- is externally observable
- can be verified with tests
- avoids vague wording

Bad specification:

- describes internal intentions
- relies on interpretation
- hides important rules

---

# Mandatory clarity elements

A correct `.feature` must make these elements explicit whenever relevant:

## Actors

Who performs the action?

Examples:
- authenticated user
- workspace admin
- billing manager
- system process

Avoid vague actors such as:
- user
- system

when roles matter.

---

## Permissions

The specification must clearly define **who is allowed to perform the action**.

Examples:

- only billing admins can download invoices
- workspace members cannot archive projects
- system administrators can restore deleted entities

If permissions are unclear, mark them as validation points.

---

## Resource state

Behavior often depends on state.

Examples:

- draft
- pending approval
- active
- finalized
- archived
- expired
- deleted
- locked

The state must be explicit whenever behavior changes based on it.

---

## Triggering action

What action triggers the behavior?

Examples:

- user clicks archive
- user submits form
- user requests export
- system processes scheduled job

The trigger must be explicit.

---

## Outcome

What must happen after the action?

Examples:

- resource is archived
- validation error is returned
- access is denied
- invoice PDF is generated
- user receives confirmation

Avoid vague outcomes such as:

- system processes the request
- data is handled properly

---

# Error and validation behavior

Specifications must define **failure conditions**, not only success paths.

Typical error cases include:

- missing required fields
- invalid format
- insufficient permissions
- invalid resource state
- duplicate action
- entity not found
- expired resource
- already processed entity

Error outcomes should be explicit whenever behavior matters.

Example:

```gherkin
Scenario: user tries to archive an already archived project
Given the project is already archived
When the user requests archive
Then the system returns an "already archived" error
```

---

# Edge cases

Edge cases must be described when they may affect behavior.

Common edge cases include:

- empty dataset
- maximum limits
- duplicate input
- boundary values
- conflicting actions
- stale state
- already processed operations

Not every feature needs many edge cases, but the obvious ones should be considered.

---

# Avoid vague language

Avoid ambiguous wording such as:

- properly
- correctly
- efficiently
- seamlessly
- if needed
- user-friendly
- fast

Replace vague words with **explicit conditions or results**.

Example:

Bad:

"the system properly validates the input"

Better:

"the system rejects the request when the email format is invalid"

---

# Scenario discipline

Each scenario should describe **one clear behavior**.

Do not mix multiple behaviors into one scenario.

Good scenario:

```gherkin
Scenario: billing admin downloads invoice PDF
Given a finalized invoice exists
And the user is a billing admin
When the user requests invoice download
Then the system returns the invoice PDF
```

Bad scenario:

- multiple unrelated actions
- hidden state transitions
- unclear expected outcomes

---

# Consistent terminology

Always use vocabulary defined in the project glossary.

Avoid synonyms for:

- entities
- roles
- workflow states
- actions
- domain objects

Consistency improves readability and prevents misunderstanding.

## When the project glossary is not available

If no project glossary exists or is accessible:

1. use the terminology from the most recent validated Product Framing Dossier as the reference vocabulary
2. use the terminology from the most recent validated `.feature` files when available
3. stay consistent within the current specification: do not use two different terms for the same concept
4. signal the absence of a formal glossary at the end of the output with a short note:

```
Note: no project glossary was available for this specification. Terminology was aligned with the Product Framing Dossier. A glossary should be created before further specification work.
```

Do not invent terminology that differs from what is already in use in validated artifacts.

---

# Scope visibility

When relevant, explicitly state boundaries.

Useful sections include:

- In scope
- Out of scope

This helps prevent scope drift during implementation.

---

# Conservative assumption rule

When a rule is missing or unclear:

1. do not invent product behavior
2. prefer the safest interpretation
3. mark the uncertainty explicitly

Possible outcomes:

- assumption
- open question
- validation required

See:
`ambiguity-policy.md`

---

# Minimal completeness checklist

Before a `.feature` is considered ready:

- the main actor is defined
- permissions are clear
- triggering action is defined
- expected outcome is explicit
- important resource states are identified
- error conditions are considered
- edge cases are considered
- vocabulary matches the project glossary
- no vague language remains
- builders would not need to invent core behavior
