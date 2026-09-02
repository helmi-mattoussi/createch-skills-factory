Feature: Submit an approval request for review

  Scenario: submit a draft approval request
    Given a draft approval request exists
    When the user submits the approval request for review
    Then the approval request moves to pending review state
