Feature: Suspend a workspace member

  Context:
    - suspension removes active workspace access without deleting the member account
    - this contract follows validated PD-117 for the member management area

  In scope:
    - single-member suspension
    - immediate removal from active workspace access
    - owner access to suspended-member visibility
    - explicit confirmation before suspension

  Out of scope:
    - deletion
    - bulk suspension
    - restore

  Business rules:
    - only workspace owners can suspend a member
    - suspension removes active workspace access immediately
    - suspended members remain visible in a dedicated suspended members view for workspace owners
    - suspension is not deletion
    - bulk suspension is not supported in this MVP
    - restore is not supported in this MVP
    - suspension requires explicit confirmation

  Permissions:
    - workspace owners can suspend a member
    - workspace managers cannot suspend a member
    - only workspace owners can access the dedicated suspended members view

  Scenario: workspace owner suspends a member
    Given a workspace member exists
    And the user is a workspace owner
    When the user confirms suspension for that member
    Then the member loses active workspace access
    And the member is suspended
    And the suspended member remains visible in the dedicated suspended members view for workspace owners

  Scenario: workspace manager tries to suspend a member
    Given a workspace member exists
    And the user is a workspace manager
    When the user requests suspension for that member
    Then the system denies the action because only workspace owners can suspend a member
    And the member remains active

  Scenario: workspace owner tries to suspend a member without confirming
    Given a workspace member exists
    And the user is a workspace owner
    When the user cancels the suspension confirmation
    Then the member remains active
    And no suspension is applied

  Scenario: workspace owner opens the dedicated suspended members view
    Given a suspended workspace member exists
    And the user is a workspace owner
    When the user opens the dedicated suspended members view
    Then the suspended member is visible in that view
