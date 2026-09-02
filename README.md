# Createch Skills Factory

Createch Skills Factory is a human-supervised agentic delivery framework for software teams, with a focus on disciplined Symfony delivery.

It packages reusable AI skills for product framing, specification, implementation planning, quality review, and release readiness. Each skill has a defined scope, explicit input and output expectations, escalation rules, and human decision gates.

## Status

This is a portfolio pilot release. It demonstrates the design, governance, and controlled validation of the skill system.

It does not claim that autonomous agents are deployed in production. It does not include live model credentials, client data, application source code, or local environment files.

## Delivery flow

```text
Brief
-> Product framing
-> Human product gate
-> Specification
-> Architecture
-> Supervised implementation
-> Quality review
-> Release recommendation
-> Human release gate
```

The governing principle is simple: agents may assist with artifacts; humans retain responsibility for product, architecture, security, and release decisions.

## Featured skills

This public release deliberately focuses on three representative skills:

| Skill | Role | Maturity |
| --- | --- | --- |
| `sdd-spec-writer` | Converts validated product intent into testable, implementation-ready behavior specifications. | Supervised |
| `quality-gate-guardian` | Reviews an implementation against its behavioral contract and makes a governed quality recommendation. | Supervised |
| `twig-fullstack-builder` | Plans a bounded Symfony/Twig module implementation from validated specifications and architecture. | Experimental |

## Guardrails

- Explicit source-of-truth hierarchy: product decisions and ADRs take precedence over tickets and existing code.
- No-invention rule: unresolved product, permission, or architecture decisions must remain visible and be escalated.
- Narrow skill boundaries: a skill must not silently take over a neighboring skill's responsibility.
- Human gates before product acceptance and release.
- Validation focuses on handoff quality, not only on the local quality of a generated artifact.

## Evidence and limitations

Controlled validation dossiers, test cases, review notes, and handoff findings are available under [`validations/`](validations/). A sanitized Symfony/Twig dry-run case study is available in [`docs/case-studies/`](docs/case-studies/).

The documented validations are not a substitute for production evidence. In particular, the current Symfony/Twig builder remains experimental and must be validated through a real, sanitized application replay with committed code and executed tests.

## Repository scope

This public repository intentionally excludes application repositories, client materials, local workspaces, environment files, archives, and runtime credentials. It is designed for technical review of the skill system itself.

## How to review

1. Start with [`skills/sdd-spec-writer/SKILL.md`](skills/sdd-spec-writer/SKILL.md).
2. Review its controlled validation evidence in [`validations/skills/sdd-spec-writer/`](validations/skills/sdd-spec-writer/).
3. Inspect the [skill-creation framework](governance/skill-creation-framework.md).
4. Read the [Symfony/Twig controlled dry-run](docs/case-studies/symfony-twig-controlled-dry-run.md).

## Ownership

Copyright 2026 Helmi Mattoussi. This repository is published for portfolio and technical-evaluation purposes.
