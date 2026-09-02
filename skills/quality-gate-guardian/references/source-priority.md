# Source Priority

Apply this order when implementation and documentation conflict:

1. applicable and most recent `PD-*` / `ADR-*`
2. validated `.feature`
3. Jira ticket
4. existing code

Consequences:
- code is never accepted as final truth over validated product or architecture artifacts
- source conflicts affecting release readiness must be made explicit
