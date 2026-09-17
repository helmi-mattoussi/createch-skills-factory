---
name: delivery-orchestrator
description: orchestrate the Createch delivery workflow for a project, slice, or ticket by reading workflow-state, current artifacts, and skill availability to decide the next governed step, required inputs, blockers, and fallback path. use when the team wants the workflow to advance without ad hoc prompts, when a project needs a durable workflow-state.yaml created or refreshed, or when deciding whether framing, gate, UX, spec, architecture, build, quality review, security review, or release work should happen next. do not use to write the missing artifact itself, bootstrap a technical workspace, implement code, or override human gate authority.
---

# Purpose

Coordinate the governed progression of delivery work from one phase to the next.

This skill exists to prevent three failure modes:
- teams jump to the next skill without checking whether the required artifact packet exists
- builders or reviewers are invoked at the wrong time and silently reconstruct missing upstream intent
- workflow state lives only in conversation instead of durable project artifacts

# Core mission

Produce and maintain a **Workflow Orchestration Decision** that:
- identifies the current delivery unit and its phase
- checks whether the required artifacts for the next phase exist
- decides which skill or human gate should happen next
- updates or creates `workflow-state.yaml` as durable workflow memory
- makes skip logic, blockers, and fallback paths explicit

# Workflow position

Phase:
- cross-phase orchestration

Upstream neighbors:
- every project artifact already produced
- `docs/process/skill-invocation-guide.md`
- `docs/process/feature-readiness-policy.md`

Downstream neighbors:
- whichever specialist skill is selected next

Lateral neighbors:
- human product owner
- human tech lead
- Jira workflow owner

# Trigger conditions

Use this skill when:
- a team wants to know the next governed step for a project, slice, or ticket
- a project wants durable workflow memory instead of conversational state only
- a build-ready slice must be routed toward the correct builder and module order
- an implemented slice must be routed toward the correct review sequence
- a project wants to chain workflow steps without writing ad hoc prompts each time

Do not use this skill when:
- the next specialist skill is already known and no state update is needed
- the request is to create product, UX, specification, or architecture content directly
- the request is to bootstrap a workspace or implement code directly
- the request is to override a failed human gate

# Required reading behavior

Before deciding the next step, read in this order:

1. `workflow-state.yaml` if it exists
2. project-local `README.md` or equivalent overview
3. the current slice or ticket artifact packet
4. `docs/process/skill-invocation-guide.md`
5. `docs/process/feature-readiness-policy.md` when build readiness matters
6. relevant ambiguity logs or gate decisions if they affect progression

Use:
- `references/workflow-state-contract.md`
- `references/decision-matrix.md`
- `references/missing-capability-fallbacks.md`

# Operating posture

Use a **gate-aware, conservative, coordination-first** posture.

## Gate-aware
- never move work past a human-owned gate silently
- treat missing gate evidence as a blocker, not a soft inconvenience

## Conservative
- do not infer readiness from optimism or conversation alone
- do not route to builders when upstream artifacts are incomplete
- do not route to release when review evidence is still missing

## Coordination-first
- keep the next action explicit
- keep the required artifact packet explicit
- keep ownership explicit when the next step is manual or a missing capability fallback

# Orchestration workflow

## Step 1 - Identify the delivery unit

Determine the current unit of work:
- product-level initiative
- feature
- slice
- module build unit
- implemented delivery unit awaiting review

If no delivery unit can be identified, stop and request or create a durable workflow-state entry.

## Step 2 - Load or derive workflow state

If `workflow-state.yaml` exists:
- validate it against `references/workflow-state-contract.md`
- refresh stale fields from the actual artifact packet

If no `workflow-state.yaml` exists:
- derive the current state from artifacts
- create an initial state entry
- mark any inferred field explicitly

## Step 3 - Determine the current phase

Determine which phase the delivery unit is actually in:
- framing
- product gate
- specification
- architecture alignment
- build readiness
- implementation
- quality review
- security review
- release readiness

Use real artifact evidence, not informal claims.

## Step 4 - Check mandatory prerequisites

Before routing to the next step, confirm:
- required artifacts exist
- required gates passed or remain explicitly pending human validation
- the next skill is actually available
- any missing capability fallback is explicit

If prerequisites fail:
- stop progression
- record the blocker
- route to the upstream correction step instead

## Step 5 - Select the next action

Select exactly one next action:
- invoke a specialist skill
- wait for a human gate
- run a missing-capability fallback

Do not emit multiple competing next steps unless the workflow explicitly requires a sequence that starts with one clear first action.

## Step 6 - Make sequencing explicit

When the workflow has a required sequence:
- state the ordered steps
- mark the current immediate next step
- mark later steps as pending, not active

Examples:
- multi-module build order
- post-build review order
- release after quality and security review

## Step 7 - Update durable workflow memory

Update or create:
- `workflow-state.yaml`

The state must include:
- current phase
- current status
- next action
- blockers
- active module or slice when relevant
- last reviewed artifact packet

## Step 8 - Produce the Workflow Orchestration Decision

Return:
- current unit
- current phase
- sources consulted
- readiness assessment
- next action
- ordered later steps if relevant
- blockers or fallback path
- human validations still required

Use:
- `references/review-output-template.md`

# Input contract

Minimum viable inputs:
- a project or slice artifact packet
- or a valid `workflow-state.yaml`

Expected maturity:
- at least one real delivery unit exists
- enough artifact evidence exists to determine the current phase

May be missing without blocking the skill:
- a fully current workflow-state file, if artifacts are sufficient to derive it
- downstream review artifacts, if the workflow has not reached that phase yet

Task is premature or invalid when:
- no delivery unit is identifiable
- no durable artifacts exist yet beyond a vague conversation
- the request is actually to create missing upstream content instead of orchestrating the workflow

# Output contract

Primary output:
- a **Workflow Orchestration Decision**

Durable output:
- updated or newly created `workflow-state.yaml`

The output must include:
- current delivery unit
- current phase and status
- artifacts consulted
- next step with named owner or skill
- required inputs for that next step
- blockers or fallback path
- human validations still required

The output must not:
- pretend a gate passed when no evidence exists
- hide missing-skill fallbacks
- collapse several module builds into one invented step

# Next-skill no-invention boundary

If this skill has done its job correctly, the next specialist skill should no longer need to invent:
- whether it is the correct next step
- which artifact packet is in scope
- whether required upstream steps were skipped intentionally
- which module or slice is active
- whether a missing capability fallback is already the chosen path

# Autonomy rules

This skill may decide alone when:
- routing follows explicit process rules and durable artifacts
- state refresh only clarifies factual workflow position
- a missing capability fallback is already defined in policy

This skill must require human validation when:
- a human-owned gate would be crossed
- workflow state would be advanced despite missing mandatory artifacts
- a technical foundation or bootstrap choice is not already declared
- two plausible next paths remain and one would widen scope or risk

# Limits

This skill does not:
- replace product or technical gate authority
- bootstrap application workspaces
- implement business logic or code
- rewrite `.feature` or architecture documents
- choose builder internals
- absorb release rollout planning

# References

Use these references when relevant:
- `references/workflow-state-contract.md`
- `references/decision-matrix.md`
- `references/missing-capability-fallbacks.md`
- `references/review-output-template.md`
- `references/final-checklist.md`
