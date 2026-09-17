# Test Cases - brief-to-product-docs

Each test case defines the input type, the expected behavior, and the expected output pattern.

---

## TC-01 - Clear but messy business brief

Input type:
- vague or unstructured client brief
- intent is recognizable but wording is mixed with solution ideas
- no source conflict

Expected behavior:
- skill extracts the business objective, problem, and first-level scope from the raw material
- separates known rules from assumptions
- produces a full Product Framing Dossier

Expected output:
- full Product Framing Dossier with honest readiness assessment

Status: executed on 2026-03-27 - pass with minor gaps

Execution reference:
- `tc-01-test-run-result.md`

Suggested first execution:
- use `pilot-test-protocol.md`
- use `fixtures/tc-01-messy-invoice-archive-brief.md`

---

## TC-02 - Ambiguous brief with 2 plausible interpretations

Input type:
- brief can be read in two different directions
- no higher-priority source resolves the ambiguity

Expected behavior:
- skill does not silently choose one interpretation
- surfaces both directions as an arbitration point
- produces the largest grounded subset without inventing a direction

Expected output:
- partial or full Product Framing Dossier with the ambiguous direction visible in `Points to arbitrate`

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-02-test-run-result.md`

Suggested first execution:
- combine with `TC-01` using `pilot-test-protocol.md`
- validate ambiguity handling through `test-run-template.md`

---

## TC-03 - Partial Jira ticket with visible objective

Input type:
- Jira ticket has a goal but is missing actors and business rules
- no PD available

Expected behavior:
- skill identifies the business goal from the ticket
- lists missing elements as open questions or assumptions
- does not invent actors or business rules silently

Expected output:
- Product Framing Dossier with partial sections, open questions explicit, readiness = Partial or No

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-03-test-run-result.md`

---

## TC-04 - Source conflict between Jira and PD

Input type:
- Jira implies one scope
- an existing PD defines a different or narrower scope

Expected behavior:
- skill follows the PD (higher-priority source)
- surfaces the conflict explicitly in the `Source-of-truth and conflicts` section
- does not silently merge both

Expected output:
- Product Framing Dossier aligned with PD + conflict made explicit + validation note

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-04-test-run-result.md`

---

## TC-05 - Scope-drift pressure toward UX / architecture / spec

Input type:
- user asks to `also design the screens`, `define the API`, or `write the .feature now`

Expected behavior:
- skill refuses to produce `.feature`, architecture, or UX design
- stays at framing level
- produces the framing dossier and says explicitly what is outside its role

Expected output:
- Product Framing Dossier only + clear statement that downstream steps handle spec, architecture, and UX

Status: executed on 2026-03-27 - pass

Execution reference:
- `tc-05-test-run-result.md`

---

## TC-06 - Handoff readiness case

Input type:
- well-framed business need with explicit scope, actors, known rules, open questions

Expected behavior:
- skill produces a full Product Framing Dossier
- the `Handoff to sdd-spec-writer` section is explicit about what the spec writer may assume and must not invent
- readiness = Yes or Partial with clear blocking items

Expected output:
- full Product Framing Dossier with well-formed handoff section

Status: executed on 2026-03-27 - pass with minor gaps

Execution reference:
- `tc-01-test-run-result.md`
