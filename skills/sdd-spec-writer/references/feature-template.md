# Feature Template

Use this template when creating a new `.feature` or when heavily restructuring an existing one.

The objective is not to fill every section mechanically.
The objective is to produce a specification that is:

- behavior-oriented
- implementation-ready
- explicit on rules and permissions
- clear on scope boundaries
- safe on ambiguities

Scenarios remain the core of the contract.
The surrounding sections exist only to reduce ambiguity and prevent builders from inventing missing rules.

---

# Recommended template

```gherkin
Feature: <short behavior-oriented title>

  Context:
    - <short business context or goal>
    - <optional second line only if useful>

  In scope:
    - <what this feature covers>
    - <optional>

  Out of scope:
    - <what this feature explicitly does not cover>
    - <optional>

  Business rules:
    - <rule 1>
    - <rule 2>
    - <rule 3>

  Permissions:
    - <actor / role> can <action> when <condition>
    - <actor / role> cannot <action> when <condition>

  Scenario: <main nominal behavior>
    Given <initial context>
    And <relevant state or permission>
    When <triggering action>
    Then <observable outcome>

  Scenario: <important validation failure>
    Given <initial context>
    And <invalid condition>
    When <triggering action>
    Then <expected validation error or refusal>

  Scenario: <important permission or state restriction>
    Given <initial context>
    And <forbidden role or blocked state>
    When <triggering action>
    Then <expected denial or blocked behavior>

  Scenario: <important edge case>
    Given <edge condition>
    When <triggering action>
    Then <expected outcome>
```

---

# Section-by-section guidance

## Feature

The title must be:

- short
- business-oriented
- behavior-oriented
- stable over time

Good examples:

- `Feature: Archive a project`
- `Feature: Download finalized invoice PDF`
- `Feature: Reopen a rejected approval request`

Bad examples:

- `Feature: Project archive button logic`
- `Feature: Invoice API`
- `Feature: Handle archive feature properly`

Do not make the title technical.

---

## Context

Use this section to provide only the minimum useful context.

Good use cases:

- explain the business goal
- clarify the actor's intent
- explain why this feature exists when the title is not enough

Keep it short.

Good:

- project archiving removes inactive projects from active operational views without deleting their history

Bad:

- long product narrative
- implementation explanation
- repeated content already obvious from scenarios

---

## In scope

Use this section when scope boundaries matter.

Include here:

- behaviors explicitly covered
- supported variants
- supported actor types if relevant
- allowed transitions in this feature

Examples:

- manual archive action from project detail page
- archive action for projects in active or paused state
- visibility change in standard project lists

Do not overload this section.

---

## Out of scope

Use this section whenever there is an obvious risk of scope drift.

Examples:

- permanent project deletion
- batch archive
- archive restoration flow
- notification redesign

This section is highly recommended for preventing builders from “helpfully” extending the feature.

---

## Business rules

This is one of the most important sections.

Use it to state rules that apply across scenarios and should not be rediscovered from scattered examples.

Typical rules include:

- lifecycle constraints
- invariants
- uniqueness rules
- retention rules
- visibility rules
- calculation rules
- domain restrictions

Examples:

- only projects in `active` or `paused` state can be archived
- archived projects remain accessible in audit history
- archiving a project does not delete related documents
- archived projects are excluded from default active project views

Business rules must be explicit and concise.

---

## Permissions

Use this section whenever access control matters.

State clearly:

- who can act
- who cannot act
- under what conditions

Examples:

- workspace admins can archive a project
- project members without admin rights cannot archive a project
- system administrators can restore archived projects

Do not hide permission logic only inside scenarios if it is globally important.

---

## Scenarios

Scenarios are the core executable contract.

Each scenario must describe one behavior only.

Use scenarios for:

- nominal behavior
- validation errors
- forbidden permissions
- forbidden state transitions
- important edge cases

A feature usually needs at least:

- one nominal scenario
- one failure or rejection scenario when relevant
- one edge or state-related scenario when relevant

---

# Scenario writing rules

## Use Given for context and state

`Given` describes:
- existing entity
- relevant actor
- relevant resource state
- prerequisite context

## Use When for one triggering action

`When` should describe a single action or event.

## Use Then for observable outcomes

`Then` should describe:
- system result
- returned error
- state transition
- visibility effect
- output artifact
- confirmation or refusal

Prefer externally verifiable outcomes.

---

# Recommended scenario set

When relevant, try to cover this minimum behavioral set:

## 1. Nominal path
What happens when everything is valid?

## 2. Validation failure
What happens when input or prerequisites are invalid?

## 3. Permission restriction
What happens when the actor is not allowed?

## 4. State restriction
What happens when the entity is in a disallowed state?

## 5. Important edge case
What happens in the most meaningful boundary condition?

Not every feature needs all five, but the writer must consciously evaluate them.

---

# Companion note template

Use a short companion note only when needed.

```md
Assumptions
- <conservative assumption explicitly made>

Open questions
- <question that affects interpretation but is not yet resolved>

Out of scope
- <important excluded point if not already explicit in the feature>

Needs validation
- <decision point requiring explicit confirmation>
```

Do not turn this into a second specification document.

---

# Example 1

```gherkin
Feature: Archive a project

  Context:
    - archiving removes inactive projects from standard active views without deleting their history

  In scope:
    - manual archive from the project detail view
    - archive of active or paused projects

  Out of scope:
    - permanent deletion
    - batch archive
    - project restoration

  Business rules:
    - only projects in active or paused state can be archived
    - archived projects remain accessible in audit history
    - archiving does not delete related documents

  Permissions:
    - workspace admins can archive a project
    - standard members cannot archive a project

  Scenario: workspace admin archives an active project
    Given an active project exists
    And the user is a workspace admin
    When the user requests project archive
    Then the project becomes archived
    And the project is removed from standard active project lists
    And the project remains accessible in audit history

  Scenario: standard member tries to archive a project
    Given an active project exists
    And the user is a standard member
    When the user requests project archive
    Then the system refuses the action because the user is not allowed to archive projects

  Scenario: user tries to archive an already archived project
    Given an archived project exists
    And the user is a workspace admin
    When the user requests project archive
    Then the system refuses the action because the project is already archived
```

---

# Example 2

```gherkin
Feature: Download finalized invoice PDF

  Context:
    - billing users need access to a stable PDF version of finalized invoices

  In scope:
    - manual PDF download from invoice detail view

  Out of scope:
    - invoice regeneration rules
    - bulk export
    - invoice email delivery

  Business rules:
    - only finalized invoices can be downloaded as PDF
    - the downloaded PDF reflects the finalized invoice version
    - draft invoices cannot be downloaded as finalized PDFs

  Permissions:
    - billing admins can download invoice PDFs
    - non-billing members cannot download invoice PDFs

  Scenario: billing admin downloads a finalized invoice PDF
    Given a finalized invoice exists
    And the user is a billing admin
    When the user requests invoice PDF download
    Then the system returns the finalized invoice PDF

  Scenario: billing admin tries to download a draft invoice PDF
    Given a draft invoice exists
    And the user is a billing admin
    When the user requests invoice PDF download
    Then the system refuses the action because only finalized invoices can be downloaded as PDF

  Scenario: non-billing member tries to download invoice PDF
    Given a finalized invoice exists
    And the user is not a billing admin
    When the user requests invoice PDF download
    Then the system refuses the action because the user is not allowed to access invoice PDFs
```

---

# Usage rules

Use the full template when:
- the feature is new
- scope boundaries matter
- permissions matter
- several business rules apply
- ambiguity risk is high

Use a lighter version when:
- the feature is very small
- scope is obvious
- no global business rules are needed
- no explicit out-of-scope section is necessary

Even in lighter mode:
- keep scenarios explicit
- keep permissions explicit when relevant
- keep business rules visible when they affect interpretation

---

# Anti-patterns

Do not produce specifications that:

- are just a list of vague scenarios
- hide global rules only inside scenarios
- omit permissions when access control matters
- omit failure behavior entirely
- mix implementation detail into behavior contract
- contain long narrative paragraphs
- silently assume unresolved business rules
- use inconsistent business vocabulary

---

# Final rule

The template is a tool for consistency, not a rigid form to complete mechanically.

A good `.feature` is one that gives builders a reliable contract with minimal room for accidental invention.
