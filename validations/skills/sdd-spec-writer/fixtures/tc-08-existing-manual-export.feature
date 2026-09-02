Feature: Export customer list

  Scenario: export customer list
    Given the user can access the customer list
    When the user requests export
    Then the system returns the customer list export
