# Writing Rules

This document defines the writing discipline for UX Design Notes.

The objective is simple:
A UX Design Note must describe interaction flows, screen structures, and UI states clearly enough that `sdd-spec-writer` does not need to invent any of them.

A good UX Design Note reduces interpretation.
A bad UX Design Note forces the spec writer to guess.

---

# Core principle

A UX Design Note describes **how the user experiences the product behavior**, not how the product is technically built.

It must focus on:
- user actions
- system responses
- screen transitions
- UI states
- form logic
- navigation paths
- UX edge cases

It must not include:
- backend logic or API design
- database structure
- framework-specific detail
- class or service design
- performance or infrastructure concerns

---

# Actor-first language

Always describe interaction from the actor's point of view.

Good:
- "the user submits the form"
- "the workspace admin selects archive"
- "the billing manager opens the invoice detail page"

Bad:
- "the system processes the submission"
- "the archive endpoint is called"
- "the component handles the click event"

Name actors using the terminology from the Product Framing Dossier.
Do not invent actor names.

---

# Behavior-oriented screen descriptions

Screen descriptions must describe **what the user can see and do**, not how the screen looks visually.

Good:
- "the invoice detail page shows: invoice number, client name, amount, status, and a Download PDF action (for billing admins only)"

Bad:
- "the page has a blue header and a white content area with a right-aligned button"

Keep visual design (colors, fonts, spacing) out of UX Design Notes.

---

# Step naming in user journeys

Use short, active-voice statements for each journey step.

Format:
```
Step 1: <actor> <action>
Step 2: <system> <response>
Step 3: <actor> <action>
```

Each step should be one sentence.
Do not describe multiple interactions in one step.

---

# State naming

Use consistent, project-aligned state names.

Match the state names used in:
- the Product Framing Dossier
- existing validated `.feature` files
- existing PD-* or ADR-*

If no state names are defined yet, use clear operational labels (Draft, Active, Archived, Locked, Pending, Rejected...) and define them the first time they appear.

---

# Form field descriptions

Be precise on forms.

For each field:
- name the field using its label as the user sees it
- state the field type (text, email, number, date, dropdown, checkbox...)
- state whether it is required
- state the validation rule if one applies
- do not invent validation rules not supported by framing or PD-*

---

# Out-of-scope sections

Use UX out-of-scope explicitly when:
- a neighboring feature or screen could be inferred by builders
- a common UX extension is obviously tempting but not in scope

Examples of what to exclude:
- "bulk archive: out of scope — only single-item archive is in scope"
- "inline editing on the list view: out of scope — editing only from the detail page"
- "search and filter on the list: out of scope — basic list only"

This prevents builders from helpfully extending the UX.

---

# Assumptions versus decisions

Distinguish clearly between:
- **Assumptions**: a UX choice made conservatively that could be challenged
- **Needs validation**: a UX decision that must be confirmed before specifying

Good assumption:
- "A1: confirmation step is assumed for the archive action because it is irreversible. Can be removed if product decides the action is low-stakes."

Good needs validation:
- "D1: it is unclear whether the download action is available to all workspace members or billing admins only. Permission model must be defined before specifying."

Do not present a Needs validation item as an assumption.

---

# Handoff clarity

The handoff section must be operationally useful to `sdd-spec-writer`.

Be specific:
- "sdd-spec-writer may assume: the archive action is on the project detail page, triggered by a button visible only to workspace admins"
- "sdd-spec-writer must not invent: whether restore behavior exists — it does not"
- "sdd-spec-writer still needs to specify: the exact error message when archive fails due to an active dependency"

Avoid vague handoff statements like:
- "the UX design provides context for the spec writer"
- "the spec writer can use this design as a starting point"

---

# Avoid vague language

Do not use:
- properly, correctly, efficiently
- user-friendly
- intuitive
- seamlessly
- fast
- if needed

Replace with specific description:
- "the form displays a validation error below each invalid field"
- "the archive button is disabled when the project has active dependencies"
- "the system returns the user to the list page after a successful submission"
