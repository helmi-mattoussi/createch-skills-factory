# Test Cases — saas-solution-architect

Each test case defines the input type, the expected behavior, and the expected output pattern.

---

## Initial architecture mode

### TC-01 — Well-scoped product with clear capabilities

Input:
- 2-3 validated Product Framing Dossiers with passed gate
- defined technology stack

Expected behavior:
- maps all capabilities to modules
- defines clean module boundaries
- lists dependencies
- proposes MVP boundary with justification
- identifies ADR needs

Expected output:
- complete Solution Architecture Map

Status: not yet executed

---

### TC-02 — Product with a pending cross-cutting technical decision

Input:
- validated framing
- technology stack partially defined
- auth strategy not yet decided

Expected behavior:
- maps modules conservatively in a technology-agnostic way
- marks auth strategy as required ADR-001
- does not hard-code an auth approach

Expected output:
- Solution Architecture Map + ADR list

Status: not yet executed

---

### TC-03 — Scope-inflation pressure

Input:
- validated framing covers 4 core capabilities
- user mentions "can we add search, analytics, and mobile app too?"

Expected behavior:
- maps only the 4 validated capabilities
- moves unframed capabilities to V2+ as "needs framing"
- does not absorb as implicit MVP scope

Expected output:
- Solution Architecture Map for the 4 validated capabilities + explicit V2+ external

Status: not yet executed

---

### TC-04 — Ambiguous module boundary

Input:
- two capabilities that could belong to one module or two

Expected behavior:
- assigns to the most natural single module or proposes a clean split
- makes boundary explicit with "Does not own"
- marks as Needs validation if the choice has product implications

Expected output:
- Solution Architecture Map + boundary decision noted

Status: not yet executed

---

## Evolution mode

### TC-05 — New capability added to existing architecture

Input:
- existing Solution Architecture Map
- new validated Product Framing Dossier for a reporting capability

Expected behavior:
- adds the reporting module without disrupting existing modules
- identifies dependencies from reporting to existing modules
- notes whether MVP or V2+
- surfaces new ADR if needed

Expected output:
- evolved Solution Architecture Map + meaningful changes noted

Status: not yet executed

---

### TC-06 — Evolution request that implies scope expansion

Input:
- existing Solution Architecture Map
- request to add a mobile app module without any product framing

Expected behavior:
- does not add the module without validated framing
- redirects to product framing
- notes the expansion as a V2+ candidate pending framing

Expected output:
- no new module + explanation + framing redirect

Status: not yet executed
