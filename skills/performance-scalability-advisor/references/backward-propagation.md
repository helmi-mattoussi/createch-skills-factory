# Backward Propagation

Route upstream when:

- intended load or scope assumptions are missing from product or architecture artifacts
- the risky path exists because architecture never defined a needed boundary or processing strategy
- the reviewed unit exposes a structural risk that should be corrected in `.feature`, `PD-*`, or module architecture rather than only treated as a release watch item

Typical return paths:
- `module-architecture-advisor` for structural performance ownership gaps
- `saas-solution-architect` if capability decomposition is wrong
- `sdd-spec-writer` if validated scope or usage assumptions are missing from behavior artifacts
