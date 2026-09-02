# Examples - Revise Mode

This document provides reference examples for **revise mode**.

Use these examples to recognize safe revision patterns when an existing `.feature` already exists.

The objective is not to rewrite for style.
The objective is to:
- preserve validated intent
- improve clarity and completeness
- surface meaningful changes
- avoid silent scope drift
- avoid normalizing implementation drift

---

# Example 1 - Editorial cleanup without contract change

## Existing feature

```gherkin
Feature: Archive a project

  Scenario: archive project
    Given a project exists
    When admin archives it
    Then it is archived
```

## Problem

The existing feature is too vague:
- actor wording is loose
- allowed states are not explicit
- scope boundaries are missing
- permission wording is weak

But no higher-priority source suggests a product change.

## Good revised output

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
```

## Why this is a good revision

- clearer wording
- explicit rules
- explicit permissions
- stronger contract
- no silent scope expansion
- no product redesign hidden inside cleanup

---

# Example 2 - Contract completion from grounded source

## Existing feature

```gherkin
Feature: Download finalized invoice PDF

  Scenario: download invoice
    Given an invoice exists
    And the user is a billing admin
    When the user downloads the invoice PDF
    Then the PDF is returned
```

## Additional grounded input

Validated product source states:
- only finalized invoices can be downloaded as PDF
- draft invoices cannot be downloaded as finalized PDFs

## Good revised output

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
```

## Meaningful changes

```md
Meaningful changes
- finalized-invoice restriction added from validated product source
- draft-invoice rejection behavior made explicit
```

## Why this is a good revision

- missing contract detail is completed from grounded source
- revision is stronger but still traceable
- meaningful changes are surfaced explicitly

---

# Example 3 - Preserve current contract against Jira drift

## Existing feature

```gherkin
Feature: Archive a project

  Business rules:
    - only workspace admins can archive a project

  Scenario: workspace admin archives a project
    Given an active project exists
    And the user is a workspace admin
    When the user requests project archive
    Then the project becomes archived
```

## New Jira wording

"Allow project members to archive projects"

## Problem

No validated PD, ADR, or approved feature update supports this permission expansion yet.

## Good revised behavior

Do not silently widen permissions.

Possible output:

```gherkin
Feature: Archive a project

  Business rules:
    - only workspace admins can archive a project

  Permissions:
    - workspace admins can archive a project
    - project members cannot archive a project

  Scenario: workspace admin archives a project
    Given an active project exists
    And the user is a workspace admin
    When the user requests project archive
    Then the project becomes archived
```

## Companion note

```md
Needs validation
- Jira suggests allowing project members to archive projects, but the current validated contract restricts archive permission to workspace admins.
- Permission expansion is not applied in this revision because no higher-priority validated source supersedes the current contract.
```

## Why this is a good revision

- preserves validated intent
- does not normalize ticket-level drift
- surfaces the requested change without hiding it

---

# Example 4 - Correct current feature from higher-priority source

## Existing feature

```gherkin
Feature: Submit an approval request for review

  Scenario: submit request
    Given a draft approval request exists
    When the user submits the request
    Then the request moves to pending review
```

## Higher-priority source says

- only users allowed to manage the approval request can submit it
- requests already under review cannot be resubmitted

## Good revised output

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
    - a request already in pending review state cannot be submitted again

  Permissions:
    - users allowed to manage the approval request can submit it for review
    - users without request management rights cannot submit it for review

  Scenario: authorized user submits a draft approval request
    Given a draft approval request exists
    And the user is allowed to manage this approval request
    When the user submits the approval request for review
    Then the approval request moves to pending review state

  Scenario: unauthorized user tries to submit an approval request
    Given a draft approval request exists
    And the user is not allowed to manage this approval request
    When the user submits the approval request for review
    Then the system refuses the action because the user is not allowed to submit this approval request

  Scenario: user tries to resubmit a request already under review
    Given an approval request in pending review state exists
    And the user is allowed to manage this approval request
    When the user submits the approval request for review
    Then the system refuses the action because only draft approval requests can be submitted
```

## Meaningful changes

```md
Meaningful changes
- permission rule added from higher-priority source
- pending-review resubmission refusal added from higher-priority source
```

## Why this is a good revision

- current feature is corrected from a stronger source
- change is explicit, not disguised as cleanup
- workflow meaning is strengthened safely

---

# Example 5 - Reject hidden scope expansion during revision

## Existing feature

```gherkin
Feature: Export customer list

  Scenario: export customer list
    Given the user can access the customer list
    When the user requests export
    Then the system returns the customer list export
```

## Revision request

"Also make it schedule a weekly export and send it by email"

## Problem

This is not a small revision.
It introduces:
- scheduled export
- email delivery
- recurring behavior
- likely new settings and permissions

## Good revised behavior

Do not silently absorb this into the current feature.

Possible revised output:

```gherkin
Feature: Export customer list

  In scope:
    - manual export of the customer list

  Out of scope:
    - scheduled export
    - recurring export
    - email delivery of exported files

  Scenario: authorized user exports the customer list manually
    Given the user is allowed to access the customer list
    When the user requests customer list export
    Then the system returns the customer list export
```

## Companion note

```md
Needs validation
- scheduled weekly export and email delivery are not treated as a simple revision of manual export
- these behaviors imply scope expansion and should be handled as explicit contract change
```

## Why this is a good revision

- scope expansion is identified and contained
- current validated contract stays clear
- no false "small improvement" framing

---

# Example 6 - Do not normalize code drift

## Existing feature

```gherkin
Feature: Restore an archived project

  Out of scope:
    - project restoration
```

## Existing code behavior

Archived projects can in fact be restored from an admin tool.

## Problem

Code behavior exists, but no validated product source has updated the contract.

## Good revised behavior

Do not add restore support to the feature just because code currently allows it.

Possible note:

```md
Open questions
- existing code appears to allow project restoration from an admin tool

Needs validation
- restore behavior is not added to the contract because current validated sources still keep restoration out of scope
```

## Why this is a good revision

- code is treated as signal, not source of truth
- drift is surfaced, not normalized
- contract remains aligned with validated intent

---

# Patterns to imitate in revise mode

## Pattern 1 - Strengthen without redesigning
Improve clarity and completeness without changing product meaning.

## Pattern 2 - Surface meaningful changes
If behavior changes, say so explicitly.

## Pattern 3 - Protect validated scope
Do not widen scope during cleanup.

## Pattern 4 - Treat Jira as request, not automatic truth
A ticket can suggest change, but does not automatically supersede the validated contract.

## Pattern 5 - Treat code drift as evidence, not authority
Code may reveal drift or hidden behavior, but should not redefine the feature alone.

---

# Anti-patterns in revise mode

Do not imitate revisions that:

- rewrite the feature elegantly while changing acceptance meaning
- turn a ticket request into validated behavior without stronger source support
- broaden permissions silently
- remove explicit constraints during cleanup
- merge distinct business behaviors into one generalized scenario
- convert out-of-scope behavior into supported behavior without validation
- use current code as justification to alter the contract
- hide scope change inside polished rewritten text

---

# Final rule

A strong revise-mode output makes the contract safer, clearer, and more explicit.

It does not quietly produce a different product.
