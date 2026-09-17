# Source Priority

Apply this order when security-sensitive implementation and documentation conflict:

1. applicable and most recent `PD-*` / `ADR-*`
2. validated `.feature`
3. Jira ticket
4. existing code

Consequences:
- code never justifies broader access than validated sources
- sensitive data behavior must be aligned with higher-priority truth
