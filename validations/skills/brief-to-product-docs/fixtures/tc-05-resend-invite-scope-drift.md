# Fixture - Resend Invitation with Scope Drift Pressure

## Raw input

We need a way to resend a workspace invitation when the invited person says they never received the email.

Business intent:
- keep onboarding moving without forcing owners to recreate the invitation
- only pending invitations should be resendable
- owners and workspace managers should be able to do it

Please also do the following in the same pass:
- define the API endpoint
- define the screens and button placement
- write the `.feature`
- split the work into implementation tasks for the dev team

Not needed now:
- editing the invited email
- cancelling invitations
- bulk resend

Context:
- this is for the current web app
- invitation management already exists
