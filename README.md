# Createch Skills Factory

Createch Skills Factory is a public portfolio of a **human-supervised agentic delivery framework** for disciplined software delivery, with a focus on Symfony projects.

It contains reusable AI skills for product framing, specification, architecture, implementation planning, quality review, operational review, and release readiness. Every skill has a bounded responsibility, defined inputs and outputs, escalation rules, and explicit human decision gates.

## Purpose of this repository

This repository is intended for technical review of the skill system. It demonstrates how AI assistance can be introduced into a delivery workflow without delegating product, architecture, security, or release responsibility to an autonomous agent.

It is not a claim of autonomous agents deployed in production.

## Full skill catalog

The repository contains all 12 skills currently designed for the framework.

| Delivery stage | Skills | Maturity |
| --- | --- | --- |
| Product framing | `brief-to-product-docs`, `workflow-ui-ux-advisor`, `sdd-spec-writer` | Supervised |
| Architecture | `saas-solution-architect`, `module-architecture-advisor` | Supervised |
| Implementation | `twig-fullstack-builder`, `delivery-orchestrator` | Experimental |
| Quality and risk review | `quality-gate-guardian`, `security-compliance-guardian`, `observability-reliability-guardian`, `performance-scalability-advisor` | Supervised |
| Release readiness | `release-rollout-advisor` | Supervised |

See [SKILLS-CATALOG.md](SKILLS-CATALOG.md) for each skill's role, evidence, and current maturity.

## Delivery flow

```text
Brief
-> Product framing
-> Human product gate
-> Specification
-> Architecture
-> Supervised implementation
-> Quality and risk review
-> Release recommendation
-> Human release gate
```

The governing principle is simple: agents may assist with artifacts; humans retain responsibility for product, architecture, security, and release decisions.

## Guardrails

- Source-of-truth hierarchy: validated product decisions and ADRs take precedence over tickets and existing code.
- No-invention rule: unresolved product, permission, or architecture decisions remain visible and are escalated.
- Narrow skill boundaries: a skill does not silently take over a neighboring skill's responsibility.
- Human gates before product acceptance and release.
- Validation focuses on handoff quality, not only on the local quality of a generated artifact.

## Evidence and limitations

Each skill exposes its instructions under [`skills/`](skills/) and its current validation status under [`validations/skills/`](validations/skills/). Representative handoff evidence is available in [`validations/handoffs/`](validations/handoffs/). A sanitized Symfony/Twig dry-run is available in [`docs/case-studies/`](docs/case-studies/).

The documented validations are controlled evidence, not production proof. Most skills still require replay on real, sanitized project cases before they can be classified as pilot-validated. The two implementation-oriented skills remain experimental and must not be presented as autonomous delivery agents.

## How to review

1. Read the [full catalog](SKILLS-CATALOG.md).
2. Start with [`skills/sdd-spec-writer/SKILL.md`](skills/sdd-spec-writer/SKILL.md) and its [validation evidence](validations/skills/sdd-spec-writer/).
3. Review the [skill-creation framework](governance/skill-creation-framework.md).
4. Inspect the [Symfony/Twig controlled dry-run](docs/case-studies/symfony-twig-controlled-dry-run.md).
5. Follow a representative artifact handoff in [`validations/handoffs/`](validations/handoffs/).

## Scope and exclusions

This public repository deliberately excludes client materials, application repositories, local workspaces, environment files, archives, and runtime credentials. It is a portfolio artifact for technical evaluation of the skill system itself.

Please read [SECURITY.md](SECURITY.md) before reporting a concern.

## Ownership

Copyright 2026 Helmi Mattoussi. Published for portfolio review and technical evaluation under the terms in [LICENSE](LICENSE).
