# Fixture - Messy Invoice Archive Brief

## Raw input

Client says the billing team is losing time because old invoices stay mixed with the active ones and people keep opening invoices that should basically be considered finished.

They want a way to archive invoices once they are really done.

It should stay simple for the first version.
No need to delete anything.

Important point from the finance lead:
- only the billing admins should be able to do this
- normal billing users should not archive anything

The user should probably confirm before archive because it changes visibility and people may click too fast.

Archived invoices should not stay in the default invoice list anymore.
But finance still wants to be able to find them somewhere else.

One unclear point from workshop notes:
- some people said "done invoices"
- some people said "finalized invoices"
- one person mentioned paid invoices too, but nobody confirmed whether paid means finalized in the current product

Not needed now:
- restore
- permanent deletion
- bulk archive
- analytics around archive usage

Context:
- existing invoicing module already exists
- current product already has billing roles
- this is for the current web app, not a mobile app
