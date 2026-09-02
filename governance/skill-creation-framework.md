# Skill Creation Framework

## Purpose

This document defines the standard method for creating reusable, reliable, workflow-compatible skills in the project.

It exists to ensure that each new skill is:
- specialized
- non-redundant
- operationally useful
- robust in real project conditions
- compatible with the surrounding workflow

This framework applies to **skill creation**, not skill usage.

---

# Core design principles

## 1. One skill, one clear role

A skill must have a precise and narrow mission.

A skill must not:
- absorb the role of multiple other skills
- become a generic assistant for a whole phase
- compensate for poor boundaries elsewhere

A skill is valid only if its role can be stated clearly in one sentence.

---

## 2. No duplicate responsibility

A new skill must not duplicate another skill’s job.

Before drafting any skill, explicitly identify:
- adjacent skills
- upstream skills
- downstream skills
- potential overlaps

If overlap exists, resolve it before writing the skill.

---

## 3. Workflow usefulness over conceptual elegance

A skill is not useful because it sounds smart.

A skill is useful because it:
- reduces ambiguity
- reduces rework
- reduces invention by downstream skills
- improves handoff quality
- improves delivery reliability

A skill must justify its existence in the actual workflow.

---

## 4. Robustness over surface quality

A skill must be designed to behave well:
- under ambiguity
- under partial inputs
- under source conflicts
- under scope pressure
- under revise/update situations when relevant

A well-written but fragile skill is not acceptable.

---

## 5. Handoff quality is part of skill quality

A skill is not evaluated only on its local output quality.

It is also evaluated on whether its output:
- is consumable by the next skill
- reduces downstream interpretation
- prevents silent compensation
- provides the right level of contract

A skill must reduce the space of invention for the next step.

---

# Mandatory design questions for every skill

Before writing the skill, answer these questions.

## 1. Mission
What is the exact mission of the skill?

## 2. Use cases
When should this skill be used?

## 3. Non-use cases
When should this skill explicitly not be used?

## 4. Inputs
What inputs does the skill expect?

## 5. Outputs
What outputs does the skill guarantee?

## 6. Dependencies
What sources, documents, artifacts, or upstream skills does it depend on?

## 7. Neighbors
Which skills sit before, after, or beside it?

## 8. Autonomy
What can it decide alone? What requires validation?

## 9. Limits
What is outside its authority or perimeter?

If one of these is unclear, the skill is not ready to be written.

---

# Required contracts for every skill

Every skill must define three contracts.

## 1. Input contract

The skill must define:
- the minimum viable input it expects
- the maturity level expected from the request
- what may be missing without blocking the skill
- what makes the task premature or invalid
- which sources it reads first

Questions to answer:
- what must already be known?
- what can still be ambiguous?
- what must be clarified upstream?

---

## 2. Output contract

The skill must define:
- what it produces
- in what form
- with what minimum level of completeness
- what must be explicit in the output
- what may remain open
- how ambiguity or validation points are surfaced

Questions to answer:
- what is the minimum guaranteed deliverable?
- what makes the output usable?
- what makes the output not ready?

---

## 3. Next-skill no-invention boundary

The skill must define:

> if this skill has done its job correctly, what should the next skill no longer be allowed to invent?

This is mandatory.

Examples:
- after a specification skill, a builder should not invent core business rules
- after a product framing skill, a spec writer should not invent the main business goal
- after a builder, a quality gate should not need to reconstruct intended behavior

This rule is essential for workflow discipline.

---

# Workflow positioning requirements

Every skill must be placed explicitly in the workflow.

Define:

## 1. Phase
At what phase does the skill intervene?

## 2. Upstream
What normally comes before it?

## 3. Downstream
What normally comes after it?

## 4. Read artifacts
What artifacts does it consume?

## 5. Produced artifacts
What artifacts does it create or modify?

Without this, the skill remains isolated and hard to integrate.

---

# Autonomy and governance requirements

Every skill must define its operating posture.

## 1. What it may do alone
Examples:
- normalize wording
- complete low-risk details
- structure material
- apply known conventions

## 2. What requires validation
Examples:
- product rule creation
- permission expansion
- scope change
- sensitive data behavior
- architecture-level choice

## 3. What must be traced
Examples:
- ambiguity
- source conflict
- conservative assumptions
- unresolved validation points

A skill must be proactive, but not silently decisive on structural matters.

---

# Perimeter discipline

A skill must be designed to resist perimeter drift.

For each skill, define:
- what belongs inside
- what belongs outside
- common ways the skill may overreach
- common ways users may mis-route work to this skill

This is especially important for:
- central skills
- synthesis skills
- revise-mode skills
- skills producing artifacts used by others

---

# Standard creation process

Use this sequence for every new skill.

## Step 1 - Challenge the perimeter

Before writing anything:
- challenge the requested scope
- identify if it is too broad, vague, or redundant
- propose a tighter role if needed
- define boundaries with neighboring skills

Do not start by drafting the skill too early.

---

## Step 2 - Define the role clearly

Clarify:
- exact mission
- when to use
- when not to use
- inputs
- outputs
- dependencies
- neighboring skills
- autonomy level
- limits

This step must produce a stable role definition.

---

## Step 3 - Define workflow position

Explain:
- where the skill intervenes
- what comes before
- what comes after
- what it reads
- what it produces or modifies

The skill must fit into the workflow before being implemented.

---

## Step 4 - Define the contracts

Write:
- input contract
- output contract
- next-skill no-invention boundary

This step is mandatory.

Do not treat these as optional notes.

---

## Step 5 - Propose the skill structure

Define:
- final skill name
- trigger description
- `SKILL.md` structure
- useful references
- useful scripts only if truly justified
- useful assets only if truly justified

Do not add scripts or assets by default.

---

## Step 6 - Produce the skill contents

Create:
- `SKILL.md`
- required references
- optional examples
- optional validation checklist
- optional revision rules if the skill supports revise mode

Keep the skill lean, but complete.

---

## Step 7 - Review the skill critically

Before validation, challenge:
- role clarity
- redundancy risk
- drift risk
- verbosity
- governance gaps
- handoff quality
- revise-mode safety where relevant

A skill should be reviewed as if it were entering a premium delivery system.

Use the standard review checklist:
- `templates/skill-review-checklist.md`

A failing item in the checklist blocks closure.

---

## Step 8 - Validate with test cases

Test the skill on realistic and adversarial cases.

Validation should include:
- easy case
- ambiguous case
- partial-input case
- source-conflict case if relevant
- revise case if relevant
- scope-drift case if relevant

A skill is not validated because its documentation looks good.

It is validated because it behaves correctly under pressure.

---

## Step 9 - Close the skill explicitly

A skill may be closed only when:
- the role is stable
- the structure is stable
- test cases are acceptable
- no structural weakness remains
- its place in the workflow is clear

Closing a skill should result in:
- validated status in `validations/skills/<skill-name>/validation-status.md`
- test cases documented in `validations/skills/<skill-name>/test-cases.md`
- review notes in `validations/skills/<skill-name>/review-notes.md`
- handoff validated in `validations/handoffs/`
- stable file structure
- explicit lessons reusable for the catalog

---


# Quality requirements for all skills

Every skill should be reviewed against these criteria.

## 1. Specialization
Is the role narrow and clear?

## 2. Practicality
Is it useful in real project work?

## 3. Output reliability
Is the output actually consumable?

## 4. Governance discipline
Does it know when not to decide alone?

## 5. Boundary clarity
Does it avoid overlap and perimeter drift?

## 6. Handoff quality
Does it reduce downstream invention?

## 7. Maintainability
Is the skill compact enough to remain usable and evolvable?

---

# Scripts and assets policy

Do not add scripts or assets unless they materially improve reliability.

## Scripts are justified when:
- deterministic transformation is needed
- repeated fragile operations exist
- consistency would otherwise be poor

## Scripts are not justified when:
- the main task is reasoning or writing quality
- the script would only give false confidence
- the task is better handled directly by the model

## Assets are justified when:
- the skill must reuse templates or output resources
- the assets are genuinely used in deliverables

Do not add scripts or assets to make the skill look more complete.

---

# Reference files policy

Reference files are encouraged when they improve:
- precision
- consistency
- robustness
- output structure
- decision handling

Typical useful references:
- writing rules
- ambiguity policy
- decision matrix
- examples
- revision rules
- final checklist

But avoid uncontrolled fragmentation.

A skill should not accumulate documents without clear purpose.

---

# Validation policy

Validation should happen in three levels.

## 1. Skill-level validation
Does the skill behave correctly on its own?

## 2. Handoff validation
Can the next skill consume the output without reconstructing intent?

## 3. Workflow validation
Does the skill contribute correctly to the chain?

Do not jump directly to full workflow validation before the skill is stable on its own.

---

# Conversation discipline

Use one conversation per skill.

This enables:
- deeper design focus
- clearer traceability
- cleaner decisions
- easier review
- better closure

Do not mix the detailed creation of multiple skills in the same conversation.

Cross-skill methodology should be extracted only after at least one real skill has been designed and validated.

---

# Closure rule

A skill may be considered closed only when it is:
- designed
- structured
- critically reviewed
- tested
- validated
- positioned in the workflow

Until then, it remains in construction.

---

# Final rule

A strong skill is not just a good instruction file.

A strong skill is a reliable workflow component with:
- a clear role
- explicit contracts
- disciplined autonomy
- robust outputs
- clean handoffs
- validated behavior
