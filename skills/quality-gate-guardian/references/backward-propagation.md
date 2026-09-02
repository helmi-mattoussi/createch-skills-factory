# Backward Propagation at Quality Gate

When quality review discovers a downstream issue that invalidates upstream truth:

## Unspecified implemented behavior
- block release
- decide whether to remove behavior or revise `.feature`
- return to `sdd-spec-writer` if the behavior should exist

## Incorrect or infeasible `.feature`
- block release
- return to `sdd-spec-writer`
- escalate to `brief-to-product-docs` or `PD-*` process if the correction is a product decision

## Architecture drift revealed during review
- block release if the drift affects correctness or maintainability materially
- return to `module-architecture-advisor` or `saas-solution-architect` as appropriate

Always keep the direction of truth:
- upstream artifact first
- downstream implementation second
