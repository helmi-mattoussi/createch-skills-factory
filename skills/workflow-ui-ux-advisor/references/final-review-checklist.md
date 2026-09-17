# Final Review Checklist

Use this checklist before considering a UX Design Note ready for `sdd-spec-writer` consumption.

The objective is not cosmetic quality.
The objective is to confirm that the UX Design Note is:
- interaction-level complete
- contractually usable by sdd-spec-writer
- properly scoped
- safe from silent UX invention
- honest about what remains unresolved

If the answer to one of the key questions is no, the UX Design Note is not ready.

---

# 1. User journey completeness

## Questions
- Is the nominal path described step by step?
- Is at least one failure or rejection path described?
- Would sdd-spec-writer understand what triggers the flow and what ends it?
- Are both entry and exit states explicit?

## If not
- add the missing path
- clarify the entry trigger
- describe the flow completion states

---

# 2. Screen structure clarity

## Questions
- Is each screen in scope described with its key elements and available actions?
- Is the entry trigger of each screen explicit?
- Are the exit paths from each screen described?
- Would builders understand what is on each screen without reconstructing it?

## If not
- add or clarify the missing screens
- make entry triggers explicit
- describe exit paths

---

# 3. UI state discipline

## Questions
- Are the relevant entity states identified when behavior changes based on them?
- Are allowed state transitions described?
- Are forbidden transitions identified where relevant?
- Has the design avoided inventing state transitions not supported by framing or PD-*?

## If not
- clarify the state model
- add explicit restrictions
- keep unsupported transitions out of scope
- mark validation for unresolved state decisions

---

# 4. Form and field completeness

## Questions
- Are all form fields listed with their type, required status, and validation rule?
- Is submission behavior described (success and failure)?
- Are validation error states described?
- Would builders know what to validate without inventing rules?

## If not
- add missing field definitions
- add submission behavior description
- clarify validation rules
- mark missing rules as Needs validation if they require product decision

---

# 5. Actor and permission clarity

## Questions
- Is the acting actor or role clearly identified throughout?
- Are actions limited to the correct actors?
- Have hidden permission expansions been avoided?
- Are sensitive or destructive actions gated with confirmation steps or validation markers?

## If not
- add or clarify actor identification
- restrict actions to the correct roles
- add Needs validation for unclear permissions
- add confirmation design for destructive actions

---

# 6. Scope discipline

## Questions
- Is the UX scope clearly bounded?
- Is an out-of-scope section present when drift risk exists?
- Has the design avoided implying related features not in scope?
- Does the design stay at interaction level (not visual design or implementation)?

## If not
- tighten scope
- add UX out-of-scope items
- remove unsupported extensions
- surface scope change explicitly

---

# 7. Source-of-truth integrity

## Questions
- Is the UX aligned with applicable PD-* and ADR-*?
- Has the design avoided contradicting validated framing?
- Has Jira been treated as input rather than ultimate truth?
- If sources conflict, has the conflict been surfaced?

## If not
- re-check source hierarchy
- restore higher-priority intent
- surface the conflict
- mark validation when structurally important

---

# 8. Ambiguity governance

## Questions
- Has the design avoided silent invention of UX decisions that require product input?
- Where UX ambiguity exists, is it treated conservatively?
- Are assumptions explicit?
- Are Needs validation items visible for all unresolved UX decisions?
- Has an ambiguity trace been created when the uncertainty materially affects sdd-spec-writer?

## If not
- separate known UX facts from UX assumptions
- add Needs validation where needed
- create or update ambiguity trace
- remove fake UX certainty

---

# 9. Handoff completeness

## Questions
- Does the handoff clearly state what sdd-spec-writer may now assume?
- Does the handoff clearly state what sdd-spec-writer must not still need to invent?
- Does the handoff state what still requires product or architecture validation?
- Would sdd-spec-writer be able to write a complete .feature without reinventing UX?

## If not
- be more specific about what is now stable
- list the remaining open points
- do not leave the handoff vague

---

# Ready / not ready rule

A UX Design Note is **ready** only if:

- the user journey covers both nominal and main failure paths
- each in-scope screen is described with its key elements and entry/exit triggers
- UI states are explicit when behavior depends on them
- form logic does not force builders to invent validation rules
- actor and permission clarity is sufficient for specification
- scope is controlled and out-of-scope is explicit when needed
- unresolved UX decisions are visible as Needs validation
- sdd-spec-writer does not need to invent core UX structure

If one of these conditions is missing, the UX Design Note is **not ready**.

---

# Final rule

Do not optimize for a complete-looking UX Design Note.

Optimize for a UX Design Note that enables `sdd-spec-writer` to write a trustworthy behavioral contract.
