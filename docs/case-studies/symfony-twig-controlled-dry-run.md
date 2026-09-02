# Symfony/Twig Controlled Dry-Run

## Purpose

This controlled dry-run evaluates whether the `twig-fullstack-builder` skill can prepare a bounded Symfony/Twig implementation without inventing product or architecture decisions.

It is planning and handoff evidence, not a claim that generated application code was executed in production.

## Scenario

A fictional back-office directory feature requires:

- authenticated staff access;
- explicit role boundaries;
- a directory module separated from identity and authentication concerns;
- traceable behavior specifications and test planning;
- no accidental expansion into unrelated product capabilities.

## Inputs

The dry-run consumes a validated module packet:

- a behavior specification expressed in Gherkin;
- product and architecture decisions;
- a module architecture document;
- a readiness decision and visible ambiguity records.

## Expected skill behavior

The skill must:

1. preserve the supplied module boundaries;
2. generate a scoped implementation plan rather than an unbounded application rewrite;
3. map scenarios to code and test locations;
4. make authorization rules explicit;
5. stop and escalate when the packet lacks a decision needed for safe implementation.

## Controlled results

Three controlled dry-runs were reviewed:

- single-module file-plan generation;
- cross-module permission mapping;
- multi-module invocation sequencing.

Each recorded pass criteria for contract intake, generation discipline, and handoff quality. The reviews found that module boundaries and access rules remained explicit, with no intentional behavior or architecture invention.

## Limitations and next milestone

The builder remains `experimental` because this case did not include a reproducible application workspace, generated Symfony code, or an executed PHP test suite.

The next milestone is a real, sanitized Symfony/Twig implementation replay with committed code, automated test output, quality review, and security review.
