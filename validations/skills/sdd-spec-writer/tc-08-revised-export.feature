Feature: Export customer list

  Context:
    - this feature covers manual export of the customer list only

  In scope:
    - manual export of the customer list on demand

  Out of scope:
    - scheduled export
    - recurring export
    - email delivery of exported files

  Business rules:
    - the feature returns a customer list export only when the user requests it manually
    - scheduled export is not part of the validated contract
    - email delivery of exported files is not part of the validated contract

  Scenario: authorized user exports the customer list manually
    Given the user is allowed to access the customer list
    When the user requests customer list export
    Then the system returns the customer list export
