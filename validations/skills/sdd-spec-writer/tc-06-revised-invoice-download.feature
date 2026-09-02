Feature: Download finalized invoice PDF

  Context:
    - billing administrators need access to the finalized invoice PDF

  In scope:
    - manual download of one finalized invoice PDF

  Out of scope:
    - invoice regeneration
    - bulk export
    - email delivery

  Business rules:
    - only finalized invoices can be downloaded as PDF in this feature
    - the feature returns the finalized invoice PDF when the actor is allowed

  Permissions:
    - billing administrators can download a finalized invoice PDF
    - users who are not billing administrators cannot download a finalized invoice PDF

  Scenario: billing administrator downloads a finalized invoice PDF
    Given a finalized invoice exists
    And the user is a billing administrator
    When the user requests the invoice PDF download
    Then the system returns the finalized invoice PDF

  Scenario: non-billing-administrator tries to download a finalized invoice PDF
    Given a finalized invoice exists
    And the user is not a billing administrator
    When the user requests the invoice PDF download
    Then the system denies access to the finalized invoice PDF
