# UX Design Note: Member suspension

## Context
- Source framing: `validations/skills/brief-to-product-docs/tc-04-product-framing-dossier.md`
- Goal: let owners suspend one member without deleting the account
- Actors:
  - owner
  - manager

## Scope
- suspend one member from the current member area
- ask for confirmation before doing it
- keep suspended members visible somewhere else later

## User journey

### Main path
1. The owner opens members.
2. The system shows active members in the current list.
3. The owner can use the suspend action on a member row.
4. A confirmation appears and says the member will lose active access.
5. The owner confirms.
6. The member disappears from the active list.
7. The owner can still find the member in the suspended area.

### Other paths
- Managers should not be able to suspend.
- If a manager reaches the route directly, access is denied.
- If the owner cancels, nothing changes.

## Screens

### Members page
- active members are shown
- row actions exist
- only owners see suspend
- there is a way to open the suspended members area

### Confirmation dialog
- explains what suspension does
- confirm button
- cancel button

### Suspended members area
- suspended members list
- way back to active members

## States
- active
- suspended

## Notes
- wording should consistently use project actor names
- wording should consistently use one label for the suspended members destination
- restore is not included
