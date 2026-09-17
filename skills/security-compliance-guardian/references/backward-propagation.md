# Backward Propagation for Security Review

When security review reveals missing or wrong upstream truth:

## Permission behavior missing from `.feature`
- block release
- return to `sdd-spec-writer`

## Sensitive visibility rule is not product-decided
- block release
- return to `brief-to-product-docs` or `PD-*` process

## Architecture does not define a required protection boundary
- block release if the gap is material
- return to `module-architecture-advisor` or `saas-solution-architect`

Never solve a security-sensitive product ambiguity only in code.
