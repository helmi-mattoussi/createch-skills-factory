# Spec Readiness Decision - billing recovery request

## Decision

No `.feature` is produced for this request.

## Why the request is not spec-ready

The request remains in discovery because multiple structural decisions are still open:

- the core behavior is not fixed between reminders, blocking, notification, or manual intervention
- the triggering rule is not defined between invoice age, subscription state, or a mixed rule
- the supported actor model is not defined
- the blocking outcome is not defined between partial and full access restriction
- the delivery channel for reminders is not defined
- plan or tenant applicability is not defined

These are not minor wording gaps.
They change product behavior, scope, permissions, and workflow meaning.

## Red flags observed

- discovery red flag: several product directions are still plausible
- product decision red flag: key business rules are not decided
- workflow red flag: the operational flow is not yet defined
- permission red flag: actor responsibility is unclear
- scope red flag: automatic and manual variants are mixed without validated boundaries

## Safe subset decision

No stable behavioral subset is grounded enough for specification at this stage.

Producing a `.feature` here would force invention on:

- trigger rules
- actors and permissions
- action outcome
- delivery channel
- scope boundary

## Recommended next step

Route this request upstream to product framing work before returning to `sdd-spec-writer`.

The minimum framing needed before specification is:

- one explicit business goal
- one stable primary workflow
- one validated trigger rule
- one validated actor model
- one explicit scope boundary
