Feature: Approve a submitted expense report

  Context:
    - approval keeps expense handling inside the current workflow
    - this contract uses the most restrictive safe interpretation until the approval actor is validated

  In scope:
    - approve one submitted expense report
    - show the approved state after approval
    - keep approval inside the existing expense workflow

  Out of scope:
    - rejection flow
    - bulk approval
    - reimbursement execution

  Business rules:
    - only one submitted expense report is approved at a time
    - only expense reports in `submitted` state are in scope for approval
    - approved expense reports no longer expose approval in this flow
    - rejection, bulk approval, and reimbursement execution are not part of this contract

  Permissions:
    - finance reviewers can approve a submitted expense report in this conservative contract
    - managers cannot approve a submitted expense report in this conservative contract until approval permission is validated

  Scenario: finance reviewer approves a submitted expense report
    Given a submitted expense report exists
    And the user is a finance reviewer
    When the user approves the expense report
    Then the expense report becomes approved
    And the approved state is visible in the workflow

  Scenario: manager tries to approve a submitted expense report
    Given a submitted expense report exists
    And the user is a manager
    When the user requests approval for the expense report
    Then the system denies the action because approval permission is not validated for that actor
    And the expense report remains submitted

  Scenario: finance reviewer tries to approve an expense report that is no longer submitted
    Given an expense report exists in `approved` state
    And the user is a finance reviewer
    When the user requests approval for the expense report
    Then the system refuses the action because only submitted expense reports can be approved
