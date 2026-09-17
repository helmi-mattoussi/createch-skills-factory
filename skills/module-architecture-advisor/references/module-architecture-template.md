# Module Architecture Template

Use this template when creating a Module Architecture Document.

The goal is not to fill every section.
The goal is to produce a document that is directly actionable for builders — they should be able to start implementing without making architectural decisions from scratch.

---

# Recommended template

```markdown
# Module Architecture: <module-name>

## Context
- Module definition source: Solution Architecture Map (reference)
- .feature sources: <list of .feature files used>
- ADR references: <list of ADR-* applied>
- Technology stack: <Symfony version, API Platform, PostgreSQL, etc.>
- Mode: framing / refactor

## Module overview

**Responsibility:**
<one sentence from the Solution Architecture Map>

**Boundary:**
- Owns: <what this module owns>
- Does not own: <what belongs to other modules>

**Exposes to other modules:**
- <API endpoints / events / shared contracts that other modules consume>

---

## Entity model

### <EntityName>
| Field | Type | Required | Description |
|---|---|---|---|
| id | uuid | yes | unique identifier |
| <field> | <string / text / int / decimal / datetime / enum / uuid-ref> | yes / no | <description> |

**Relationships:**
- <EntityName> → <OtherEntity>: <many-to-one / one-to-many / many-to-many> — <brief reason>

**Source:** <grounding: .feature filename or PD-* reference>

---

[repeat for each entity]

---

## State machine (if applicable)

### <EntityName> lifecycle

States:
| State | Meaning |
|---|---|
| <state-1> | <what it means operationally> |
| <state-2> | <what it means operationally> |

Allowed transitions:
| From | To | Actor | Trigger |
|---|---|---|---|
| <state-1> | <state-2> | <actor/role> | <event or action> |

Forbidden transitions:
- <state-A> cannot transition to <state-B> — reason: <why>

**Source:** .feature/<filename>.feature

---

## API contract

### <HTTP METHOD> <route>

**Operation:** <action name in domain language>
**Actor:** <role>
**Input:** <fields and types, or "none">
**Output:** <fields and types, or "empty with HTTP 204">
**Main errors:**
- <HTTP status>: <reason>
- <HTTP status>: <reason>

**Source:** .feature/<filename>.feature

---

[repeat for each API operation]

---

## Service layer structure

### <ServiceName>

**Responsibility:**
<one sentence — what this service does>

**Not responsible for:**
<what it delegates to another service or module>

**Operates on:**
- <Entity 1>
- <Entity 2>

**Depends on:**
- <Other module or service — reason>

---

[repeat for each main service]

---

## Architecture patterns applied

| Pattern | Applied to | Reason |
|---|---|---|
| <pattern name> | <which part of the module> | <why it is needed> |

---

## Implementation contract for builders

**This section is mandatory.** Do not leave it blank.
The architect decides at the **pattern and constraint level**.
The builder translates these decisions to the appropriate framework components.

### 1. Separation of concerns

Does the complexity of this module's domain logic justify strict separation between business logic and infrastructure?

- [ ] **Basic** — service layer is sufficient. Business logic lives in focused service classes.
  - Use when: module has simple, direct business rules, no complex domain model, no rich entity behavior
- [ ] **Strict** — domain model is complex enough to warrant isolation from infrastructure and delivery concerns.
  - Use when: entities have rich behavior, multiple domain events, complex invariants, or the module is a candidate for future extraction

Decision: ___
Reason: ___

### 2. Write operation coupling

Should write operations be independent of the HTTP delivery layer?

- [ ] **Coupled** — services are called directly from controllers. Operations are synchronous and HTTP-bound.
  - Use when: default choice. The flow is synchronous and user-facing. Do not optimize for hypothetical future needs.
- [ ] **Decoupled** — write operations are expressed as independent commands, separable from HTTP.
  - Use when: operations are heavy enough to strictly require asynchronous processing (background jobs, queues), or complex batch processing. Do not choose this just for "better separation" or future-proofing.

Decision: ___
Reason: ___

### 3. State machine governance

Does the lifecycle of an entity require strict transition governance?

- [ ] **None** — no meaningful state machine in this module
- [ ] **Simple** — basic status tracking: small number of states, single actor, no conditional guards
- [ ] **Strict** — multiple actors, conditional transitions, or transitions must be auditable and configurable

Decision: ___
Reason: ___

### 4. Module reuse scope

Is this module designed to be usable outside this specific project? Check the `saas-solution-architect` output.

- [ ] **Project-specific** — tailored to this project's context. Entities can declare hard Doctrine relations to other project entities.
- [ ] **100% Reusable** — targeted for extraction as a standalone package. **Strict rules apply:**
  - 🚫 No hardcoded foreign keys to external entities (use `UUID` or `EntityInterface`).
  - 🚫 No direct service calls to external modules (use Domain Events).
  - 🚫 No hardcoded project configuration (must be injectable via Bundle Configuration).

Decision: ___
Reason: ___
Extraction target: Phase ___ / Not planned


---

## Module-specific ADR needs

| # | Decision needed | Why it matters | Options | Recommendation |
|---|---|---|---|---|
| ADR-XXX | <topic> | <consequence if unresolved> | A / B | <conservative option> |

---

## Assumptions

- A1: <architecture assumption made conservatively>
- A2: <assumption made>

## Needs validation

- D1: <architecture decision requiring team validation>
- D2: <decision needing input from another stakeholder>

## Handoff to builders

### May assume
- <what builders can treat as decided>

### Must not invent
- <what builders should not still need to decide architecturally>

### Builder judgment applies to
- <implementation-level choices: naming, code style, method decomposition, test strategy>
```

---

# Section-by-section guidance

## Entity model

One entity definition per major domain object.

What goes in:
- fields directly required by validated `.feature` behaviors
- fields required by the state machine
- fields required by the API contract
- relationships required by the behavioral contract

What does not go in:
- speculative fields ("what if we need to track X")
- fields from existing code not supported by validated behavior
- fields that belong to another module's entity

For field types, use simple descriptive types, not ORM-specific types.
Good: `string`, `text`, `integer`, `decimal`, `datetime`, `uuid`, `enum`, `boolean`, `uuid-ref (→ Entity)`
Avoid: `VARCHAR(255)`, `BIGINT`, `@Column`, `nullable=true`

## State machine

Only design a state machine if the module has a lifecycle entity.

Grounding rule:
- only states and transitions that appear in validated `.feature` or PD-* are confirmed
- potential future states should be listed as V2+ or Needs validation

The "Forbidden transitions" section is as important as the allowed ones.
If it is not stated, builders will invent it.

## API contract

One block per API operation (not per entity CRUD method).

Use domain action names for routes:
- /invoices/{id}/archive (not /invoices/{id}/status)
- /workspace/members/invite (not /workspace/members POST)

Input and output shape should describe what the API exposes, not the internal entity.
They do not need to be exhaustive — list the main fields.

## Service layer structure

Aim for 3-7 services per module.
Fewer than 3 often means responsibilities are mixed.
More than 7 often means artificial over-splitting.

Each service should be nameable in a clear action phrase.
Good: `InvoiceArchiver`, `MemberInvitationHandler`, `WorkspaceMemberResolver`
Bad: `InvoiceManager`, `WorkspaceHelper`, `UtilService`

## Architecture patterns

Only include patterns that are genuinely applied.
Each pattern must be justified by the module's specific complexity.

Do not list patterns to look sophisticated.

## Implementation contract for builders

Rule: every checkbox in the "Implementation contract for builders" section must be checked with a clear decision.
Module-architecture-advisor must not leave the decision blank and let the builder decide.
The builder reads this section first and its code structure follows from it.

If the implementation contract is missing or incomplete, the builder must:
1. Stop generation
2. Flag: "Implementation contract is missing in the Module Architecture Document — cannot determine code structure. Return to module-architecture-advisor."
3. Not apply any default pattern

## ADR needs

List only genuine module-specific decisions.
Cross-cutting ADR needs identified by `saas-solution-architect` are already listed there.

Module-specific examples:
- row-level security enforcement approach for this module
- caching strategy for this module's read-heavy operations
- async vs sync implementation of a specific operation
- PDF generation integration approach

---

# Anti-patterns

Do not produce a Module Architecture Document that:
- defines entities with fields not grounded in validated behaviors
- creates services without clear single responsibilities
- applies patterns "just because" without justification
- skips the state machine when it is clearly present
- designs APIs that do not map to validated .feature operations
- mixes this module's entity with another module's entity
- leaves the handoff section vague
- over-engineers for scalability concerns not required by the product scope
