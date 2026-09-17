# Skills Catalog

This catalog describes the full public skill set as of the `v0.2-full-catalog` portfolio release.

## Maturity labels

- **Supervised**: the skill has bounded responsibilities, explicit review expectations, and requires human decisions at defined gates. It is not production-certified.
- **Experimental**: the skill is intended for controlled pilot use only. It needs additional real-project replays before broader use.
- **Pilot-validated**: reserved for a future release after documented real-project validation. No skill in this repository currently claims this level.

## Product framing

| Skill | What it does | Maturity | Evidence |
| --- | --- | --- | --- |
| `brief-to-product-docs` | Converts a raw brief into a structured product-framing dossier while surfacing ambiguities. | Supervised | Validation status, controlled test cases, review notes |
| `workflow-ui-ux-advisor` | Designs or revises workflow and UX decisions while preserving scope and permission constraints. | Supervised | Validation status, controlled test cases, review notes |
| `sdd-spec-writer` | Produces testable behavior specifications from validated product intent. | Supervised | Controlled test runs, fixtures, handoff evidence |

## Architecture

| Skill | What it does | Maturity | Evidence |
| --- | --- | --- | --- |
| `saas-solution-architect` | Defines solution boundaries, module ownership, identity, tenancy, and architecture decisions for SaaS products. | Supervised | Validation status, test cases, review notes |
| `module-architecture-advisor` | Produces bounded module architecture guidance for implementation and review. | Supervised | Validation status, test cases, handoff evidence |

## Implementation

| Skill | What it does | Maturity | Evidence |
| --- | --- | --- | --- |
| `twig-fullstack-builder` | Plans a bounded Symfony/Twig module implementation from validated specifications and architecture. | Experimental | Controlled Symfony/Twig dry-run, validation dossier |
| `delivery-orchestrator` | Routes validated artifacts through the delivery workflow and prepares handoffs between stages. | Experimental | Validation status and handoff rules |

## Quality, risk, and release

| Skill | What it does | Maturity | Evidence |
| --- | --- | --- | --- |
| `quality-gate-guardian` | Reviews an implementation against its behavioral contract and issues a governed quality recommendation. | Supervised | Validation status, test cases, review notes |
| `security-compliance-guardian` | Identifies security and compliance risks before release promotion. | Supervised | Validation status, test cases, review notes |
| `observability-reliability-guardian` | Reviews operational visibility, resilience, and reliability risks. | Supervised | Validation status, test cases, review notes |
| `performance-scalability-advisor` | Reviews performance and scalability risks, including query and throughput concerns. | Supervised | Validation status, test cases, review notes |
| `release-rollout-advisor` | Produces a release recommendation and identifies rollout risks and mitigations. | Supervised | Validation status, test cases, review notes |

## What the evidence demonstrates

The included evidence demonstrates that the skills were designed with explicit boundaries, validation cases, review notes, and handoff expectations. It does not demonstrate autonomous production operation, live model orchestration, or production reliability.

## Recommended recruiter review path

1. `sdd-spec-writer`: review a concrete specification skill and its controlled cases.
2. `module-architecture-advisor`: review architectural boundaries and downstream handoff requirements.
3. `quality-gate-guardian`: review how the framework prevents unsupported promotion of generated work.
4. `twig-fullstack-builder`: inspect the experimental Symfony/Twig implementation path and its stated limits.
