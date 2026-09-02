Feature: Submit an approval request for review

  Context:
    - submission sends a prepared approval request into the review workflow

  In scope:
    - manual submission of a draft approval request for review

  Out of scope:
    - review decision flow
    - reassignment of reviewers
    - resubmission of rejected requests

  Business rules:
    - only approval requests in `draft` state may be submitted for review
    - submission changes the approval request state from `draft` to `pending review`
    - only users allowed to manage the approval request may submit it for review

  Permissions:
    - users allowed to manage the approval request can submit it for review
    - users without approval-request management rights cannot submit it for review

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

  Scenario: user tries to submit an approval request that is already under review
    Given an approval request in `pending review` state exists
    And the user is allowed to manage this approval request
    When the user submits the approval request for review
    Then the system refuses the action because only draft approval requests can be submitted for review
