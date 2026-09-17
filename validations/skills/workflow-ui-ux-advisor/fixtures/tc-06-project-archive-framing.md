# Product Framing Dossier

## 1. Header
- Topic: Archive a completed project from the active project list
- Sources:
  - synthetic validation fixture for `workflow-ui-ux-advisor`
- Status: PASS WITH EXPLICIT FOLLOW-UPS
- Owner: Product review pending

## 2. Business objective
- Objective: Let project administrators archive completed projects so active project management remains focused without deleting project data.
- Expected value:
  - reduce clutter in the active project list
  - preserve historical project visibility
  - avoid deletion requests for completed projects

## 3. Problem to solve
- Current pain/problem:
  - completed projects stay mixed with active projects
  - teams keep opening projects that no longer require active handling
- Why it matters now:
  - project volume is increasing
  - archive is a safer alternative than deletion

## 4. Scope
### In scope
- archive one completed project
- remove archived projects from the default active list
- keep archived projects accessible in a separate archive area
- restrict the action to project administrators

### Out of scope
- deletion
- restore
- bulk archive

## 5. Actors
- Primary actors:
  - project administrator
- Secondary actors:
  - project contributor

## 6. Known business rules
- R1: Archive is not deletion.
- R2: Only completed projects may be archived.
- R3: Only project administrators may archive a project.
- R4: Archived projects leave the active list and remain accessible in a separate archive area.

## 7. Assumptions
- A1: None at framing level.

## 8. Open questions
- Q1: None blocking at framing level.

## 9. Points to arbitrate / Needs validation
- D1: The framing does not explicitly confirm whether archive requires a confirmation step.

## 10. Risks / vigilance points
- downstream work must not drift into deletion
- permission visibility must remain restricted to project administrators

## 11. Source-of-truth and conflicts
- Sources used:
  - synthetic validation fixture
- Conflicts detected:
  - none
- Provisional resolution:
  - none needed

## 12. Ambiguity log references
- none

## 13. Readiness for specification
- Ready for spec: Partial
- Stable enough:
  - business goal and scope are clear
  - actor boundary is clear
- Blocking items:
  - confirm whether archive confirmation is a validated product rule or only a conservative UX treatment

## 14. Product Quality Gate
- Decision: PASS WITH EXPLICIT FOLLOW-UPS
- Reason:
  - the core archive behavior is stable enough for downstream work
  - the confirmation treatment remains a bounded UX uncertainty

## 15. Handoff to sdd-spec-writer
### May assume
- archive is not deletion
- only completed projects are archive-eligible
- only project administrators may archive
- archived projects leave the active list and remain available in a separate archive area

### Must not invent
- deletion behavior
- restore behavior
- bulk archive behavior
- broader permission access

### Still needs to specify
- scenario wording
- refusal behavior
- whether confirmation is a product rule or a conservative UX assumption
