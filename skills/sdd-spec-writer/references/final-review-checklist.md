# Final Review Checklist

Use this checklist before considering a `.feature` ready for downstream builders.

The objective is not cosmetic quality.
The objective is to confirm that the specification is:

- behaviorally clear
- contractually complete enough
- properly scoped
- safe from silent invention
- usable by builders without reconstructing missing intent

If the answer to one of the key questions is no, the spec is not ready yet.

---

# 1. Contract clarity

Check that the feature expresses a clear behavioral contract.

## Questions

- Is the main business goal clear?
- Is the triggering action explicit?
- Is the expected outcome explicit?
- Is the wording observable and testable?
- Does the feature avoid vague wording such as "properly", "correctly", or "if needed"?
- Are scenario titles clear and behavior-oriented?
- Would two different builders likely interpret the same core behavior the same way?

## If not
- clarify wording
- make outcomes explicit
- split overloaded scenarios
- remove ambiguous language

---

# 2. Actor and permission clarity

Check that role and access behavior are sufficiently explicit.

## Questions

- Is the acting user or system actor clearly identified?
- Are permissions explicit where access matters?
- Are forbidden actors or roles covered where relevant?
- Has the spec avoided silently broadening access?
- If permission remains unclear, is that uncertainty visible and marked for validation?

## If not
- add or clarify `Permissions`
- narrow the interpretation conservatively
- add `Needs validation` for unresolved sensitive permission issues

---

# 3. Business-rule completeness

Check that the feature does not force builders to invent core rules.

## Questions

- Are the main business rules stated explicitly?
- Are global rules centralized rather than hidden only inside scenarios?
- Are important invariants or restrictions visible?
- Are rules grounded in validated sources rather than inferred from convenience?
- If a rule was completed conservatively, is that visible when needed?

## If not
- add or clarify `Business rules`
- remove unsupported invented rules
- surface assumptions explicitly

---

# 4. State and lifecycle discipline

Check that workflow meaning is stable.

## Questions

- Are relevant states explicit when behavior depends on them?
- Are allowed state transitions clearly described?
- Are forbidden or blocked transitions covered where relevant?
- Has the spec avoided inventing restore, reopen, retry, resubmit, or rollback behavior?
- If state-transition behavior is unclear, is that uncertainty surfaced?

## If not
- clarify state language
- add explicit state restrictions
- keep unsupported transitions out of scope
- mark validation for unresolved lifecycle decisions

---

# 5. Error and edge-case coverage

Check that the spec is not only a happy-path document.

## Questions

- Is nominal behavior covered?
- Is at least one meaningful failure path covered when relevant?
- Are validation errors covered where input constraints matter?
- Are permission refusals covered where access matters?
- Are important edge cases covered when they could affect implementation or acceptance?
- Would builders still need to guess obvious rejection behavior?

## If not
- add missing failure scenario
- add validation scenario
- add explicit refusal or state-restriction scenario
- add important edge-case coverage

---

# 6. Scope discipline

Check that the feature remains tight and does not drift.

## Questions

- Is the supported behavior clearly bounded?
- Is `Out of scope` present when hidden expansion risk exists?
- Has the feature avoided silently implying related variants?
- Has revise mode avoided widening scope unintentionally?
- Does the current output stay focused on one meaningful contract rather than a broad product area?

## If not
- tighten scope
- add `Out of scope`
- remove unsupported extensions
- surface scope change explicitly instead of hiding it

---

# 7. Source-of-truth integrity

Check that the specification follows the project's priority rules.

## Questions

- Is the feature aligned with applicable `PD-*` and `ADR-*`?
- If an existing validated `.feature` existed, was its intent preserved unless explicitly superseded?
- Has Jira been treated as input rather than ultimate truth?
- Has current code been treated as signal rather than authority?
- If sources conflict, has the conflict been surfaced rather than silently merged?

## If not
- re-check source hierarchy
- restore higher-priority intent
- surface the conflict
- mark validation when structurally important

---

# 8. Revision safety

Use this section specifically in revise mode.

## Questions

- Has the revision preserved validated intent by default?
- Are meaningful behavior changes explicitly surfaced?
- Has the revision avoided presenting contract change as editorial cleanup?
- Have explicit constraints from the previous feature been preserved unless superseded?
- Has revision avoided normalizing Jira drift or code drift?

## If not
- reclassify the change
- restore preserved constraints
- add a `Meaningful changes` note
- remove ungrounded contract modifications

---

# 9. Ambiguity governance

Check that uncertainty is handled visibly and correctly.

## Questions

- Has the spec avoided silent invention of structural business behavior?
- Where ambiguity exists, is it treated conservatively?
- Are assumptions explicit when useful?
- Are open questions visible when they materially affect interpretation?
- Is `Needs validation` used for unresolved structural issues?
- Has an ambiguity trace been created when the uncertainty materially affects the contract?

## If not
- separate known facts from assumptions
- add companion note
- create or update ambiguity trace
- remove fake certainty

---

# 10. Delivery readiness

This is the final decision point.

## Questions

- Could a builder implement this without inventing a core business rule?
- Could a builder implement this without guessing core permissions?
- Could a builder implement this without guessing main acceptance outcomes?
- Is the behavioral core stable enough for downstream implementation?
- If only a partial subset is stable, is that limitation made explicit?

## If not
- do not mark the feature as ready
- reduce the contract to the stable subset
- surface missing decisions
- require upstream clarification or validation where needed

---

# Output quality signals

A feature is usually strong when it is:

- explicit without being verbose
- narrow without being incomplete
- structured without being mechanical
- conservative without being blocked
- readable by humans and reliable for builders

A feature is usually weak when it is:

- elegant but ambiguous
- complete-looking but ungrounded
- technically suggestive instead of behaviorally clear
- broad and underspecified
- reliant on implied rules that are not actually written

---

# Ready / not ready rule

A `.feature` is **ready** only if:

- the main behavior is explicit
- permissions are clear where relevant
- important rules are visible
- failure behavior is not missing where it matters
- scope is controlled
- ambiguity is governed explicitly
- builders do not need to invent central business behavior

If one of these conditions is missing, the `.feature` is **not ready**.

---

# Final rule

Do not optimize for a clean-looking specification.

Optimize for a trustworthy behavioral contract.
