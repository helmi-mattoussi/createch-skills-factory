# Performance Risk Patterns

Treat these as high-signal patterns:

- list or search behavior with no pagination or bounded result strategy
- obvious N+1 or repeated fan-out access on a growing path
- synchronous request path doing batch or file-heavy work
- reporting or aggregation behavior on unbounded data without any guardrail
- async throughput path with no batching or rate control where volume is clearly relevant

Treat these as moderate-signal patterns:

- safe MVP shape but no explicit watch item for expected data growth
- no benchmark exists, but the structure suggests a manageable follow-up rather than a blocker
- cacheable hot path exists with no caching yet, but current scope is still credibly small
