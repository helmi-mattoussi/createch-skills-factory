# Final Review Checklist

Use this checklist before considering a Module Architecture Document ready for builders.

---

# 1. Input traceability

- [ ] Module definition from Solution Architecture Map was used
- [ ] All validated .feature files for this module were read
- [ ] Applicable ADR-* were consulted
- [ ] Technology stack is defined

---

# 2. Entity model

- [ ] Every entity is grounded in validated .feature or PD-*
- [ ] Every field has a source (or is clearly labeled as a technical assumption)
- [ ] Fields not in any .feature are marked as assumptions
- [ ] No fields belong to another module's entity
- [ ] Relationships are explicit and directional

---

# 3. State machine (if applicable)

- [ ] All states in validated .feature are present
- [ ] All transitions in validated .feature are listed
- [ ] Forbidden transitions are explicitly stated
- [ ] Each transition identifies the actor that triggers it
- [ ] No ungrounded states or transitions are included as confirmed

---

# 4. API contract

- [ ] Every .feature behavioral scenario has a corresponding API operation
- [ ] API operations use domain action names (not generic CRUD labels)
- [ ] Input shape is described for each operation
- [ ] Output shape is described for each operation
- [ ] Main error cases are listed for each operation
- [ ] No API operations exist without a .feature source

---

# 5. Service layer

- [ ] Each service has one clear responsibility stated in one sentence
- [ ] Each service has a "not responsible for" section
- [ ] Services do not overlap in responsibility
- [ ] Total number of services is reasonable (3–7 for most modules)
- [ ] Services are named with action-oriented domain names

---

# 6. Architecture patterns

- [ ] Each pattern is listed and justified
- [ ] Pattern justification connects to module complexity or .feature requirement
- [ ] No pattern is listed without use
- [ ] Over-engineering was actively challenged

---

# 7. ADR needs

- [ ] All module-specific architecture decisions that need formal resolution are listed
- [ ] Each ADR need has a consequence statement
- [ ] No sensitive decision was made unilaterally without an ADR

---

# 8. Ambiguity and assumptions

- [ ] Assumptions are explicit with A1, A2... labels
- [ ] Needs validation items are explicit with D1, D2... labels
- [ ] No product decision was made silently
- [ ] The document does not pretend things are decided when they are not

---

# 9. Handoff completeness

- [ ] Builders can identify all entities and their fields without reconstruction
- [ ] Builders can implement the state machine without redesigning it
- [ ] Builders can implement all API operations without designing their contract
- [ ] Builders can organize services without inventing responsibilities
- [ ] The document is clear about what remains for builder-level judgment

---

# Ready / not ready rule

A Module Architecture Document is ready when:

- all entities are defined with grounded fields
- the state machine is complete for the validated behaviors
- all API operations in the .feature are covered with their contract
- all services have a clear single responsibility
- patterns are justified
- builders do not need to make architectural decisions from scratch

If any of these are missing, the document is not ready.
