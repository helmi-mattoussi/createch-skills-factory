# Createch Skills Factory

**A supervised agentic delivery pipeline for Symfony projects.**

I do not let an AI agent write the application. I give it bounded skills, explicit handoff
contracts, and human approval gates — so that generated code stays traceable three months later.

---

## The problem

AI-assisted delivery is fast on day one and unmaintainable on day thirty.

Generated code is plausible. It compiles, it looks like the rest of the codebase, and nobody
remembers who decided what, or why this table exists. The speed gained at the start is paid back
in reviews that catch fewer defects than before, because there is no contract to review against.

This repository is my answer to that: not "use AI less", but **give it boundaries it cannot cross**.

---

## The approach

Twelve bounded skills cover the delivery cycle, from framing to release:

Each skill declares:

- **what it receives and what it produces** — no open-ended conversation;
- **an explicit handoff contract** — the next skill knows what it starts from;
- **an escalation rule** — when to stop and ask a human rather than invent;
- **a human checkpoint** — this is where a decision gets made, and recorded.

Two rules hold the whole thing together:

1. **No validated specification, no generated code.** The `.feature` file comes first.
2. **No invention.** When a source is missing, the pipeline says so. It does not fill the gap.

---

## Evidence

- **27 controlled scenarios**, including one that explicitly forbids the model from giving the
  exercise answer to a learner.
- **12 skills documented**: 10 supervised, 2 experimental. The maturity table is published, not
  hidden.
- **A source-of-truth hierarchy** and a written no-invention rule, both enforced at the handoff.
- **A skill-creation framework**: how to add a skill without breaking the existing ones.

> This is a **public portfolio** of a methodology under consolidation. It is not a claim of
> autonomous agents deployed in production.

---

## What a run looks like

The failing test in step 3 is not a formality. It is the contract that prevents a
plausible-but-wrong implementation from passing as done.

---

## Stack

| Layer | Tooling |
| --- | --- |
| Application | Symfony 7, API Platform |
| Specification | Gherkin / Behat, `FriendsOfBehat/SymfonyExtension` |
| Static analysis | PHPStan, Deptrac |
| CI | GitHub Actions |
| Front-end | Cypress + Cucumber (documented, not yet replayed on every project) |

---

## Repository layout

---

## Reading path

If you have two minutes: `SKILLS-CATALOG.md`.
If you have ten: the catalog, then one skill and its validation, then the governance framework.
If you are evaluating: `docs/case-studies/` — the dry-runs are published with their limitations.

---

## Status and limits

- Consolidation in progress. Two skills are experimental and marked as such.
- A dry-run against a local Symfony/Twig pilot is underway; several skills still need replaying on
  sanitised real projects before being called pilot-validated.
- No client code, no credentials, and no application repository lives here.

---

## Licence

MIT — see `LICENSE`.

---

*Method and implementation by [Helmi Mattoussi](https://www.linkedin.com/in/helmi-mattoussi-a07a8445/) —
Tech Lead & Software Architect.*
