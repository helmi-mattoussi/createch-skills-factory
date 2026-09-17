# Decision Matrix

## Purpose

Use this matrix to choose the next governed action from the current artifact state.

## Core routing

| Observed state | Next action |
|---|---|
| raw brief only | `brief-to-product-docs` |
| framing exists, no product gate decision | human `Product Quality Gate` |
| gate passed, UI flow exists, no UX note | `workflow-ui-ux-advisor` |
| gate passed, no `.feature` yet | `sdd-spec-writer` |
| `.feature` exists, new capability or no module map | `saas-solution-architect` |
| `.feature` exists, module map exists, no module architecture | `module-architecture-advisor` |
| module architecture exists, not build-ready | upstream correction path |
| slice is ready for build, workspace missing | manual bootstrap fallback or future bootstrap capability |
| slice is ready for build, workspace ready, stack is Symfony/Twig | `twig-fullstack-builder` |
| build completed, no quality review | `quality-gate-guardian` |
| quality review passed and the slice is security-sensitive | `security-compliance-guardian` |
| quality or security review surfaces operability risk | `observability-reliability-guardian` |
| architecture or review evidence surfaces meaningful performance risk | `performance-scalability-advisor` |
| required reviews passed, release planning still needed | `release-rollout-advisor` |

## Builder-specific routing

### Greenfield build unit

If:
- `workspace_mode: greenfield`
- `workspace_state: missing` or `bootstrap-required`

Then:
- do not invoke the builder yet
- route first to the declared bootstrap strategy or manual bootstrap fallback

### Existing project build unit

If:
- `workspace_mode: existing-project`
- `workspace_state: ready`

Then:
- route directly to the correct builder for the stack

### Multi-module slice

If:
- several module architecture documents exist
- build order is explicit

Then:
- invoke the builder one module at a time
- keep only the immediate module as active

## Review routing

### Quality before specialist review

Default order:
1. `quality-gate-guardian`
2. `security-compliance-guardian` when the slice touches auth, permissions, PII, billing, file access, or destructive actions
3. `observability-reliability-guardian` when runtime operability or failure visibility is a meaningful concern
4. `performance-scalability-advisor` when latency, throughput, or data-volume risk is meaningfully in play
5. `release-rollout-advisor` after required reviews are complete

Do not route straight to release from code completion.

## Stop rules

Stop and route upstream when:
- a mandatory artifact is missing
- a required gate has not passed
- the selected builder would need to invent module order or ownership
- the stack or workspace strategy is not yet declared
