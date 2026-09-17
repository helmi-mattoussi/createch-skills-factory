# Final Review Checklist

Use this checklist before considering a Solution Architecture Map ready for `module-architecture-advisor` consumption.

---

# 1. Input completeness

- [ ] At least one Product Framing Dossier with passed gate was used as input
- [ ] Technology stack is identified or the assumption of technology-agnostic design is stated
- [ ] Applicable PD-* and ADR-* were consulted

---

# 2. Capability map

- [ ] All major product capabilities from the framing are represented
- [ ] Capability names use product vocabulary, not technical vocabulary
- [ ] No capability from the framing is missing without explicit justification

---

# 3. Module map

- [ ] Every module has exactly one sentence of responsibility
- [ ] All capabilities map to at least one module
- [ ] No module responsibility overlaps another module without explicit boundary

---

# 4. Module definitions

- [ ] Every module has an "Owns" section
- [ ] Every module has a "Does not own" section
- [ ] Every module has an "Exposes" section (what it makes available to others)
- [ ] Every module has notes for module-architecture-advisor
- [ ] No module contains implementation details (class names, service names, ORM mapping)

---

# 5. Dependency map

- [ ] All module-to-module dependencies are listed with direction and nature
- [ ] All external system dependencies are listed
- [ ] Circular dependencies are identified and resolved or flagged
- [ ] Dependency direction is explicit (which module depends on which)

---

# 6. MVP delivery boundary

- [ ] Every module is assigned MVP or V2+
- [ ] MVP assignment is justified briefly
- [ ] V2+ assignment has a reason (not just implied)
- [ ] The MVP is not inflated with non-essential capabilities

---

# 7. Macro delivery order

- [ ] A rough delivery sequence is proposed for MVP modules
- [ ] Foundational modules appear first
- [ ] Dependencies are respected in the sequencing

---

# 8. ADR decisions

- [ ] All genuinely cross-cutting decisions are identified as required ADRs
- [ ] Each ADR need has a clear topic and consequence statement
- [ ] No sensitive decision has been made unilaterally without an ADR

---

# 9. Ambiguity and assumptions

- [ ] Architecture assumptions are explicit
- [ ] Unresolved architecture decisions are marked as Needs validation
- [ ] No product decision has been made silently

---

# 10. Handoff readiness

- [ ] module-architecture-advisor can start on any module without reconstructing its identity or boundary
- [ ] sdd-spec-writer was not circumvented (no .feature content in the map)

---

# Ready / not ready rule

A Solution Architecture Map is **ready** when:

- all product capabilities from validated framing are mapped
- every module has a clear, bounded responsibility
- the dependency map is explicit and directional
- the MVP boundary is decided and justified
- all required ADR decisions are identified
- module-architecture-advisor has a useful and grounded starting point for each module

If any of these are missing, the map is **not ready**.
