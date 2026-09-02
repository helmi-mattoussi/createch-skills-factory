# Examples - Create Mode

This document provides reference examples for **create mode**.

Use these examples to recognize strong specification patterns when drafting a new `.feature` from scoped inputs.

The objective is not to copy examples mechanically.
The objective is to imitate:
- behavioral clarity
- explicit rules
- scope discipline
- permission clarity
- useful scenario coverage

---

# Example 1 - Simple action with permissions

## Input shape

Typical request:
- a project can be archived from its detail page
- only workspace admins can archive
- archive removes the project from standard active views
- archive does not delete history

## Good output

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

## Why this is strong

- actor and permission are explicit
- allowed states are explicit
- out-of-scope prevents hidden expansion
- nominal, permission, and state-restriction scenarios are covered
- no implementation detail appears

---

# Example 2 - Validation-oriented feature

## Input shape

Typical request:
- user can invite a teammate by email
- invitation requires a valid email
- duplicate pending invitation should not be created
- only workspace admins can invite teammates

## Good output

```gherkin
Feature: Invite a teammate to a workspace

  Context:
    - workspace admins can invite new teammates by email

  In scope:
    - single invitation by email
    - invitation to an existing workspace

  Out of scope:
    - bulk invitation
    - invitation by shareable link
    - role editing after invitation creation

  Business rules:
    - invitation email must use a valid email format
    - a duplicate pending invitation for the same email must not be created
    - accepted invitations are no longer considered pending

  Permissions:
    - workspace admins can invite teammates
    - non-admin workspace members cannot invite teammates

  Scenario: workspace admin invites a new teammate
    Given a workspace exists
    And the user is a workspace admin
    And no pending invitation exists for invited.user@example.com
    When the user invites invited.user@example.com to the workspace
    Then the system creates a pending invitation for invited.user@example.com

  Scenario: workspace admin submits an invalid email address
    Given a workspace exists
    And the user is a workspace admin
    When the user invites invalid-email to the workspace
    Then the system refuses the request because the email format is invalid

  Scenario: workspace admin submits a duplicate pending invitation
    Given a workspace exists
    And the user is a workspace admin
    And a pending invitation already exists for invited.user@example.com
    When the user invites invited.user@example.com to the workspace
    Then the system refuses the request because a pending invitation already exists for this email

  Scenario: non-admin member tries to invite a teammate
    Given a workspace exists
    And the user is not a workspace admin
    When the user invites invited.user@example.com to the workspace
    Then the system refuses the action because the user is not allowed to invite teammates
```

## Why this is strong

- input validation is explicit
- duplicate behavior is specified as business rule and scenario
- permissions are not left implicit
- the feature remains focused and does not drift into onboarding flow design

---

# Example 3 - Workflow with state transitions

## Input shape

Typical request:
- an approval request can be submitted for review
- only draft approval requests can be submitted
- submit moves the request from draft to pending review
- requests already under review or finalized cannot be resubmitted

## Good output

```gherkin
Feature: Submit an approval request for review

  Context:
    - submission sends a prepared approval request into the review workflow

  In scope:
    - manual submission of a draft approval request

  Out of scope:
    - review decision flow
    - reassignment of reviewers
    - resubmission of rejected requests

  Business rules:
    - only draft approval requests can be submitted for review
    - submission changes the request state from draft to pending review
    - a request already in pending review or finalized state cannot be submitted again

  Permissions:
    - users allowed to manage the approval request can submit it for review
    - users without request management rights cannot submit it for review

  Scenario: authorized user submits a draft approval request
    Given a draft approval request exists
    And the user is allowed to manage this approval request
    When the user submits the approval request for review
    Then the approval request moves to pending review state

  Scenario: authorized user tries to submit a request already under review
    Given an approval request in pending review state exists
    And the user is allowed to manage this approval request
    When the user submits the approval request for review
    Then the system refuses the action because only draft approval requests can be submitted

  Scenario: unauthorized user tries to submit an approval request
    Given a draft approval request exists
    And the user is not allowed to manage this approval request
    When the user submits the approval request for review
    Then the system refuses the action because the user is not allowed to submit this approval request
```

## Why this is strong

- lifecycle meaning is explicit
- transition is specified clearly
- forbidden transitions are covered
- the feature does not silently imply rejection, resubmission, or review behavior

---

# Example 4 - Download feature with scope discipline

## Input shape

Typical request:
- billing admins can download finalized invoice PDFs
- draft invoices cannot be downloaded as finalized PDFs
- feature is about manual download only

## Good output

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

## Why this is strong

- scope is kept narrow
- business rule and permission are explicit
- no accidental expansion into export, delivery, or generation logic
- scenarios cover nominal, validation, and permission cases

---

# Patterns to imitate in create mode

When drafting a new `.feature`, prefer these patterns:

## Pattern 1 - State global rules once
If a rule applies across multiple scenarios, place it in `Business rules`.

## Pattern 2 - Keep permissions visible
If access matters, use a `Permissions` section rather than hiding everything inside scenarios.

## Pattern 3 - Use `Out of scope` to prevent drift
When builders may infer related variants, explicitly exclude them.

## Pattern 4 - Cover more than the happy path
At minimum, think about:
- nominal behavior
- invalid input or invalid state
- forbidden permission
- one meaningful edge case when relevant

## Pattern 5 - Keep the feature focused
A strong `.feature` describes one meaningful contract, not a whole module.

---

# Anti-patterns in create mode

Do not imitate outputs that:

- describe implementation details
- omit permissions when they matter
- omit state restrictions when lifecycle matters
- use vague outcomes such as "the system handles the request correctly"
- silently imply related variants
- cover only the happy path
- turn a small feature into a broad product document

---

# Final rule

A strong create-mode output is one that gives builders a reliable behavioral contract without making them reconstruct hidden rules from context.
