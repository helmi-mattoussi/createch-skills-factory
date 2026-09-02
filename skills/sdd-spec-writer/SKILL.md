---
name: sdd-spec-writer
description: write or revise implementation-ready .feature specifications from a validated product framing dossier that has passed the product quality gate, from jira tickets that have grounded framing, from validated flows, or from existing feature files. use when a feature must be clarified before coding, when expected behaviors, business rules, permissions, edge cases, error cases, or acceptance scenarios need to be formalized, or when an existing .feature is too vague, incomplete, inconsistent, or misaligned with current product decisions. do not use directly on a raw brief or on needs that have not yet been framed — use brief-to-product-docs first in those cases.
---

# Purpose

Write or revise `.feature` specifications that are clear, testable, implementation-ready, and aligned with the project's validated product and architecture decisions.

This skill exists to enforce **spec before code**. It turns already scoped intent into a behavioral contract that builders can implement without inventing business rules.

The skill must improve clarity, completeness, and traceability while staying disciplined:
- do not do product discovery
- do not design architecture
- do not write implementation code
- do not silently invent structural business behavior

# Core mission

Produce or revise `.feature` files that:
- express expected behaviors in an observable way
- make business rules explicit
- capture permissions and access rules
- cover nominal flow, error cases, and edge cases
- identify assumptions, open questions, and validation points when needed
- remain aligned with the project's source-of-truth hierarchy

# Source-of-truth policy

Always resolve information using this priority order:

1. applicable and most recent `PD-*` and `ADR-*`
2. validated `.feature` files
3. Jira ticket
4. existing code

If sources conflict:
- follow the higher-priority source
- do not silently merge conflicting intentions
- explicitly flag the conflict
- mark validation as required when the conflict changes behavior, permissions, or scope

Never treat existing code as the primary truth when product or architecture documentation says otherwise.

See:
- `references/source-priority.md`

# Operating posture

Use a **conservative, explicit, delivery-oriented** posture.

## Conservative
When a detail is unclear:
- prefer the least risky interpretation
- do not broaden permissions
- do not invent destructive or irreversible behavior
- do not add product scope that was not requested

## Explicit
When something is missing or ambiguous:
- state assumptions clearly
- isolate open questions
- mark validation points
- create an ambiguity trace when the uncertainty is structurally important

## Delivery-oriented
Write for builders. A good output is not merely readable. It must be implementable with minimal interpretation.

When the full contract cannot be written safely, draft the **largest grounded subset** that can be specified without invention, and make the unresolved remainder visible.

Do not block unnecessarily when a stable partial contract can still be delivered.

# Modes

This skill operates in two modes.

## Mode 1 - Create
Use when no usable `.feature` exists and a new one must be written from available scoped inputs.

## Mode 2 - Revise
Use when a `.feature` already exists but is:
- too vague
- incomplete
- inconsistent
- outdated
- misaligned with product decisions
- missing business rules, permissions, or error handling

In revise mode:
- preserve validated intent whenever possible
- improve contract quality without changing scope unless a higher-priority source requires it
- explicitly highlight meaningful changes

See:
- `references/revision-rules.md`

# Required reading behavior

Before drafting, inspect the relevant available inputs and classify them:

- product decisions
- architecture decisions
- existing feature files
- ticket intent
- ui/ux flow inputs
- glossary and naming conventions
- project process constraints

When reading inputs:
- normalize vocabulary using project terminology
- identify scope boundaries
- identify actor types and permission levels
- identify state transitions
- identify validations, invariants, and failure modes
- identify unresolved ambiguities

If critical information is absent, do not fabricate certainty.

# Drafting workflow

## 1. Determine whether the request is create or revise
Decide whether to:
- create a new `.feature`
- revise an existing `.feature`
- refuse to proceed as a spec-writing task because the need is still too underdefined

If the need is still in discovery or arbitration phase, say so clearly and redirect conceptually to upstream framing rather than pretending specification is ready.

Use:
- `references/red-flags.md`

## 2. Extract the contract backbone
Identify at minimum:
- business goal
- primary actor(s)
- trigger/action
- expected outcome
- constraints
- permission boundaries
- validation rules
- error paths
- relevant edge cases
- explicit out-of-scope items when visible

## 3. Resolve against source hierarchy
Cross-check the extracted contract against:
- `PD-*`
- `ADR-*`
- existing validated `.feature`
- Jira
- current code only as a secondary signal

If there is drift or contradiction:
- keep the higher-priority intent
- flag the mismatch
- do not optimize for current code convenience

Use:
- `references/source-priority.md`

## 4. Decide how far the contract can safely go
Choose one of these outcomes:
- full `.feature`
- `.feature` plus short companion note
- partial `.feature` covering only the grounded subset
- no full spec because the task is still upstream discovery or requires explicit decision first

When unsure, prefer a grounded subset over a complete-looking but invented contract.

Use:
- `references/decision-matrix.md`
- `references/ambiguity-policy.md`

## 5. Produce the `.feature`
Write a structured, stable, implementation-ready `.feature` using the project template and rules.

Use:
- `references/spec-writing-rules.md`
- `references/feature-template.md`

## 6. Add companion note only when needed
When the contract is not fully closed, add a short companion block with only relevant sections:
- `Assumptions`
- `Open questions`
- `Out of scope`
- `Needs validation`

Keep it short. This is not a second spec.

## 7. Trace ambiguities when structurally required
If ambiguity affects business behavior, permissions, validation logic, sensitive data handling, important edge cases, or cross-source consistency:
- create or update an ambiguity trace
- state what was unclear
- state the conservative interpretation used, if any
- state what needs explicit validation

Use:
- `references/ambiguity-policy.md`

## 8. Finalize only if the contract is truly ready
Before finalizing:
- verify that builders will not need to invent core behavior
- verify that meaningful unresolved points are visible
- verify that revise mode did not silently change the product
- verify that scope boundaries are controlled

Use:
- `references/final-review-checklist.md`

## 9. Stop before implementation
Do not provide code, class design, schema design, API details, framework structure, or implementation plan unless the user explicitly asks for a separate downstream step.

# Output contract

The primary output is:
- a `.feature` file
- a revised `.feature` body
- or a partial `.feature` covering only the grounded subset

The output must be:
- behavior-oriented
- concrete
- testable
- easy for builders to consume
- consistent in wording
- minimal in fluff
- explicit about rules and constraints

The output must not:
- read like a PRD
- contain architecture prose
- contain speculative product decisions presented as facts
- hide unresolved points
- look complete when important parts are still ungrounded

# Writing rules

Apply these writing rules strictly.

## Write observable behavior
Prefer statements that can be checked from outside the implementation.

Good:
- user with billing admin role can download the invoice PDF for a finalized invoice
- system refuses archive action when the workflow is still running

Bad:
- system handles invoice retrieval correctly
- archive uses safe process

## Make actors and permissions explicit
Always specify:
- who acts
- under what role or permission set
- under what resource state
- with what outcome

## Make state explicit
When behavior depends on state, state it clearly.

Examples:
- draft
- pending approval
- finalized
- archived
- expired
- deleted
- locked

## Cover errors and edge cases
A `.feature` is incomplete if it only describes the happy path.

Systematically think about:
- invalid input
- missing prerequisites
- unauthorized access
- forbidden state transition
- duplicate action
- already processed entity
- empty result
- boundary values
- concurrent or stale state if relevant

## Avoid vague wording
Avoid words like:
- properly
- correctly
- appropriately
- if needed
- user-friendly
- seamless
- fast

Replace them with explicit conditions or outcomes.

## Keep scenarios tight
Each scenario should express one meaningful behavior. Do not overload scenarios with multiple unrelated intentions.

## Use project vocabulary
Prefer glossary-approved terms over synonyms. Use stable names for roles, entities, states, and workflow steps.

# Spec shape

Use a disciplined hybrid structure: Gherkin-centered, with a few surrounding sections when useful.

A typical output may contain:
- `Feature`
- optional brief `Context`
- optional `In scope`
- optional `Out of scope`
- `Business rules`
- `Permissions`
- `Scenarios`

Do not mechanically force every section if it adds no value. Use only the sections that improve clarity.

Always ensure scenarios remain the behavioral core.

# Quality bar

A spec is ready only if a builder can implement it without needing to invent:
- the main behavior
- core business rules
- access conditions
- obvious failure handling
- important edge behavior

If too much invention would still be required, the spec is not ready. Reduce it to the stable subset or surface the blocking points.

# Escalation rules

Mark validation or escalation required when the request touches any of the following:
- structural product rule not already decided
- conflicting source-of-truth inputs
- sensitive permission rule
- security-sensitive behavior
- personal or regulated data handling
- destructive or irreversible action
- scope increase beyond documented intent
- architectural choice requiring ADR-level decision
- major UX behavior not yet validated

In these cases:
- still provide the conservative contract when possible
- isolate the decision point clearly
- do not present the unresolved choice as settled

# Ambiguity discipline

Do not log trivial wording ambiguities.

Create or update an ambiguity trace when uncertainty materially affects:
- business behavior
- permissions
- validations
- data visibility
- state transition
- cross-team expectations
- acceptance outcome

When ambiguity exists, clearly distinguish:
- what is known
- what is assumed conservatively
- what must be validated

See:
- `references/ambiguity-policy.md`

# Interaction boundaries with other skills

This skill is adjacent to other skills but must not absorb their job.

## Upstream neighbors
- `brief-to-product-docs`: clarifies and structures a still-fuzzy need
- `saas-solution-architect`: defines overall solution shape and boundaries
- `workflow-ui-ux-advisor`: designs workflow and experience details

## Lateral neighbor
- `module-architecture-advisor`: resolves implementation-shaping technical structure when needed

## Downstream neighbors
- `symfony-apiplatform-builder`
- `angular-feature-builder`
- `twig-fullstack-builder`
- `quality-gate-guardian`

If the task requires upstream discovery or downstream implementation, stay in spec-writer scope and say what is missing or what should happen next.

## UX dependency rule

Some `.feature` specifications depend on UX and interaction design choices that are not yet decided.

Examples of UX-dependent spec elements:
- the trigger action depends on a UI entry point not yet designed
- the workflow step sequence is unclear
- the meaning of confirm / cancel / submit depends on an interaction not yet stabilized
- state transitions change based on an interface flow not yet validated

When this occurs:

**Do not lock UX-dependent behavior as if it were decided.**

Expected operating posture:
1. identify which parts of the behavioral contract do not depend on UX choices
2. draft the UX-independent subset as the stable spec core
3. mark UX-dependent behaviors explicitly with `Needs validation`
4. redirecte conceptually to `workflow-ui-ux-advisor` when the UX gap is structurally blocking

This skill must not design the UX itself.
It may use UX outputs as inputs, but must not invent them.

If `workflow-ui-ux-advisor` has not yet been used and the spec depends heavily on undesigned UX:
- produce only the UX-independent part of the spec
- surface the dependency explicitly
- do not block completely unless no stable subset is extractable

# Minimal checklist before finalizing

Before delivering the result, verify:
- is the business goal clear
- are actors and permissions explicit
- are key rules stated
- are normal and error behaviors both covered
- are important edge cases covered
- is vocabulary consistent with project terms
- are scope limits visible where needed
- are ambiguities traced when structurally relevant
- is anything presented as certain that is actually inferred
- would a builder still need to invent core behavior

If the answer to the last question is yes, the spec still needs work.

# References to consult

Use these references selectively:

- `references/feature-template.md` for create-mode structure
- `references/revision-rules.md` for revise-mode safety
- `references/spec-writing-rules.md` for writing quality
- `references/ambiguity-policy.md` when uncertainty affects the contract
- `references/decision-matrix.md` for output choice and escalation choice
- `references/red-flags.md` when the request may not yet be spec-ready
- `references/source-priority.md` when sources conflict or drift is suspected
- `references/final-review-checklist.md` before finalizing
- `references/examples-create.md` and `references/examples-revise.md` for strong reference patterns
