# Examples

Use these examples to recognize strong framing patterns and common anti-patterns.

The goal is not to copy examples mechanically.
The goal is to imitate:
- the correct level of framing (not spec, not architecture)
- the separation between rules, assumptions, and questions
- the honesty of the readiness assessment
- the quality of the handoff section

---

# Example 1 — Clear but messy business brief → full dossier

## Input

Jira ticket: "Need a way to archive finalized invoices because the active invoice list is noisy."

## Good framing output

**Business objective:**
- Reduce operational noise for finance users by separating active from finalized invoices.

**Problem to solve:**
- Finalized invoices appear in the active invoice list alongside ongoing work, causing confusion and slowing down daily operations.

**Scope:**
- Archive finalized invoices
- Hide archived invoices from standard active invoice views

**Out of scope:**
- Invoice deletion
- Reporting redesign
- PDF export changes

**Actors:**
- Primary: accountant, finance manager
- Secondary: system administrator (potential restore capability — not scoped here)

**Known business rules:**
- R1: only finalized invoices may be archived

**Assumptions:**
- A1: archiving is a manual action triggered by the user (not automatic)
- A2: archived invoices remain accessible in audit or archive view

**Open questions:**
- Q1: who exactly can archive? All finance users or only finance managers?
- Q2: can archived invoices be restored? If yes, by whom?

**Points to arbitrate:**
- D1: the permission model for archive action must be decided before specification

**Readiness for specification:**
- Ready: Partial
- Stable enough: objective, problem, scope, out-of-scope, actors
- Blocking items: permission model (D1), restore behavior (Q2)

**Handoff to sdd-spec-writer:**
- May assume: archiving is a manual action, only finalized invoices can be archived, archived invoices stay visible in archive view
- Must not invent: who can archive, restore behavior
- Still needs to specify: permission scenarios, archive action trigger, archive list behavior

## Why this is strong

- scope is narrow and honest
- known rules are separated from assumptions
- blocking items are explicit
- handoff reduces what sdd-spec-writer must reconstruct

---

# Example 2 — Ambiguous brief with two directions → partial dossier with arbitration

## Input

Workshop notes: "Users want some kind of approval flow before invoices are sent to clients."

## Good framing output

**Business objective:**
- Add a control step before invoices are sent externally to improve accuracy and reduce errors.

**Problem to solve:**
- Invoices can currently be sent directly without any internal review, causing errors to reach clients.

**Points to arbitrate:**
- D1: two directions are possible and must be chosen before specification:
  - Direction A: lightweight single-step approval by finance manager before send
  - Direction B: multi-step approval flow (preparer → reviewer → approver) with role-based gate
- The choice between these directions has major scope consequences and must not be assumed.

**Readiness for specification:**
- Ready: No
- Blocking items: D1 must be arbitrated before this can become a specification input

**Handoff to sdd-spec-writer:**
- Must not invent: the approval flow model — this is the open arbitration point

## Why this is strong

- the skill does not choose a direction silently
- both directions are described without bias
- the handoff section is honest: the dossier blocks until D1 is resolved

---

# Example 3 — Scope-drift request → framing only, explicit refusal of downstream steps

## Input

"We need to archive invoices. Can you also write the .feature and define the screens?"

## Good framing behavior

Produce the Product Framing Dossier for the archive framing, then clearly state:

- `.feature` writing is the responsibility of `sdd-spec-writer`, not this skill
- screen design is the responsibility of `workflow-ui-ux-advisor`, not this skill

Only the framing dossier is produced. The rest is redirected.

## Why this is strong

- the skill stays in its lane
- the refusal is explicit and helpful, not silent
- the framing is still produced and useful

---

# Example 4 — Source conflict between Jira and an existing PD

## Input

- Jira ticket says: "Allow all users to archive their own invoices"
- PD-007 says: "Only finance managers can archive invoices"

## Good framing behavior

**Source-of-truth and conflicts:**
- Sources used: Jira ticket, PD-007
- Conflict detected: Jira implies broad self-service access, PD-007 restricts to finance managers
- Provisional resolution: PD-007 is followed as the higher-priority source

**Points to arbitrate:**
- D1: if the Jira ticket reflects a genuine intent to change the permission model, PD-007 must be updated before this dossier can progress

**Readiness for specification:**
- Ready: Partial
- Blocking items: permission conflict must be resolved (D1)

## Why this is strong

- the conflict is not merged silently
- the higher-priority source is followed
- the next step for humans is explicit
