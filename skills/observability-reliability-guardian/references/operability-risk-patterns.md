# Operability Risk Patterns

Treat these as high-signal patterns:

- background or scheduled work with no actionable failure surface
- external integration with no explicit timeout, failure handling, or operator visibility
- file processing that can fail silently or leave partial state
- important runtime behavior with no meaningful log or trace signal
- user-visible success while background completion can fail later without surfacing
- recovery that exists only in developer knowledge, not in durable review output

Treat these as moderate-signal patterns:

- watch items exist but are vague
- errors are logged but not attributable to a business unit or actor
- runtime behavior is visible only through manual database inspection
