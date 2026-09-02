Feature: Suspend a workspace member

  Context:
    - suspension removes one member from active workspace access without deleting the account
    - suspended members remain reviewable by workspace owners in a dedicated suspended members view

  In scope:
    - single-member suspension from the active member list
    - confirmation before suspension
    - owner-only access to the dedicated suspended members view

  Out of scope:
    - deletion
    - bulk suspension
    - restore
    - self-service member suspension

  Business rules:
    - only active workspace members can be suspended in this feature
    - only workspace owners can suspend a member
    - suspension removes active workspace access immediately
    - suspension removes the member from the active member list
    - suspended members remain visible in the dedicated suspended members view for workspace owners
    - suspension is not deletion
    - suspension requires explicit confirmation

  Permissions:
    - workspace owners can suspend an active workspace member
    - workspace managers cannot suspend a member
    - regular workspace members cannot suspend a member
    - only workspace owners can access the dedicated suspended members view

  Scenario: workspace owner suspends an active member
    Given an active workspace member exists in the active member list
    And the user is a workspace owner
    When the user confirms suspension for that member
    Then the member becomes suspended
    And the member no longer appears in the active member list
    And the suspended member appears in the dedicated suspended members view
    And the user sees a success confirmation

  Scenario: workspace owner cancels suspension confirmation
    Given an active workspace member exists in the active member list
    And the user is a workspace owner
    When the user cancels the suspension confirmation for that member
    Then the member remains active
    And the member remains visible in the active member list
    And no suspension is applied

  Scenario: workspace manager tries to suspend a member
    Given an active workspace member exists
    And the user is a workspace manager
    When the user requests suspension for that member
    Then the system denies the action because the user is not allowed to suspend members
    And the member remains active

  Scenario: workspace owner confirms suspension after the member is no longer eligible
    Given an active workspace member exists in the active member list
    And the user is a workspace owner
    And the member is no longer active by the time the user confirms suspension
    When the user confirms suspension for that member
    Then the system refuses the action because only active members can be suspended
    And no suspension is applied

  Scenario: workspace owner opens the dedicated suspended members view
    Given a suspended workspace member exists
    And the user is a workspace owner
    When the user opens the dedicated suspended members view
    Then the suspended member is visible in that view

  Scenario: workspace manager tries to open the dedicated suspended members view
    Given a suspended workspace member exists
    And the user is a workspace manager
    When the user opens the dedicated suspended members view
    Then the system denies access to that view
