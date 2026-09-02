Feature: Download invoice pdf

  Scenario: admin downloads a finalized invoice
    Given a finalized invoice exists
    And the user is billing admin
    When the user downloads the invoice pdf
    Then the pdf is returned

  Scenario: someone else tries to download invoice pdf
    Given a finalized invoice exists
    And the user is not billing admin
    When the user downloads the invoice pdf
    Then access is denied
