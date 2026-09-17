# Final Review Checklist

- Is the reviewed sensitive scope explicit?
- Were validated `.feature` files and applicable `PD-*` / `ADR-*` checked?
- Are server-side permission controls reviewed, not only UI controls?
- Was sensitive data exposure considered in views, responses, files, and logs?
- Were destructive or irreversible actions reviewed for safeguards?
- Is there credible evidence for critical denial or protection paths?
- Are blockers separated from hardening follow-ups?
- Is backward propagation recommended where upstream truth is insufficient?
- Would release planning still need to reconstruct the security conclusion?
