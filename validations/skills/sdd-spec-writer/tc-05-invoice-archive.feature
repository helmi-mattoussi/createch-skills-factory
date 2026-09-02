Feature: Archive a finalized invoice

  Context:
    - archiving removes a finalized invoice from the default active list without deleting invoice data

  In scope:
    - archive one finalized invoice from the active invoice list
    - require confirmation before archive
    - keep archived invoices visible in the archive view for billing administrators

  Out of scope:
    - batch archive
    - restore
    - permanent deletion
    - archive search
    - archive filtering

  Business rules:
    - only finalized invoices can be archived in this feature
    - only billing administrators can archive an invoice
    - archiving does not delete invoice data
    - archived invoices are removed from the active invoice list
    - archived invoices remain visible in the archive view for billing administrators
    - archive requires explicit confirmation

  Permissions:
    - billing administrators can archive a finalized invoice
    - billing viewers cannot archive an invoice
    - only billing administrators can access the archive view

  Scenario: billing administrator archives a finalized invoice
    Given a finalized invoice exists in the active invoice list
    And the user is a billing administrator
    When the user confirms archive for that invoice
    Then the invoice becomes archived
    And the invoice no longer appears in the active invoice list
    And the archived invoice appears in the archive view
    And the user sees a success confirmation

  Scenario: billing administrator cancels archive confirmation
    Given a finalized invoice exists in the active invoice list
    And the user is a billing administrator
    When the user cancels the archive confirmation for that invoice
    Then the invoice remains visible in the active invoice list
    And no archive is applied

  Scenario: billing viewer tries to archive an invoice
    Given a finalized invoice exists
    And the user is a billing viewer
    When the user requests archive for that invoice
    Then the system denies the action because the user is not allowed to archive invoices
    And the invoice remains visible in the active invoice list

  Scenario: billing administrator tries to archive an invoice that is no longer finalized
    Given an invoice exists in `sent` state
    And the user is a billing administrator
    When the user requests archive for that invoice
    Then the system refuses the action because only finalized invoices can be archived
    And the invoice remains visible in the active invoice list

  Scenario: billing administrator opens the archive view
    Given an archived invoice exists
    And the user is a billing administrator
    When the user opens the archive view
    Then the archived invoice is visible in that view
