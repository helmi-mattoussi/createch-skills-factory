# UX Output Template

Use this template when creating a new UX Design Note.

The objective is not to fill every section mechanically.
The objective is to produce a UX Design Note that:
- describes the interaction flow clearly enough to be specifiable
- leaves no screen trigger, navigation step, or state transition for sdd-spec-writer to invent
- surfaces all unresolved UX decisions explicitly
- respects the Product Framing Dossier without re-doing its job

---

# Recommended template

```markdown
# UX Design Note: <flow or feature title>

## Context
- Source framing: <Product Framing Dossier reference>
- Business goal: <one line from framing>
- Actors covered: <from framing>

## In scope (UX)
- <what interaction behavior is covered>
- <which screens or steps are in scope>

## Out of scope (UX)
- <what is explicitly excluded from this UX design>
- <neighboring behaviors not designed here>

## User journey

### Nominal path
Step 1: <actor does X>
Step 2: <system responds with Y>
Step 3: <actor does Z>
...
Outcome: <what the actor achieves>

### Failure path(s)
Step 1: <actor does X>
Step 2: <system rejects because Y>
Outcome: <what the actor sees and can do>

## Screen structure

### Screen: <name>
- Entry trigger: <what causes the user to arrive here>
- Layout summary: <key sections or panels>
- Key elements: <main content, actions, states shown>
- Primary action: <the main action available>
- Secondary actions: <other available actions>
- Exit paths: <where the user can go from here>

### Screen: <name>
[repeat for each screen in scope]

## UI states

### <entity or screen name>
| State | Meaning | Visible elements | Actions available |
|---|---|---|---|
| <state 1> | <what it means> | <what is shown> | <what actor can do> |
| <state 2> | <what it means> | <what is shown> | <what actor can do> |

### Forbidden transitions
- <state A> cannot transition to <state B> in this flow

## Form structure

### Form: <name>
| Field | Type | Required | Validation |
|---|---|---|---|
| <field name> | <text / select / date / etc.> | Yes / No | <rule> |

Submission behavior:
- Success: <what happens>
- Validation error: <what is shown and where>
- System error: <fallback behavior>

## Navigation flow

<Describe verbally or in a simple diagram the navigation between screens>

Entry point → Screen A → [action] → Screen B → [success] → Screen C
                      → [error] → Error state → Screen A

## UX edge cases

- Edge case 1: <situation> → <expected UX behavior>
- Edge case 2: <situation> → <expected UX behavior>

## UX constraints

Constraints from PD-* or ADR-*:
- <constraint 1> (source: PD-XXX)
- <constraint 2> (source: ADR-XXX)

## Assumptions

- A1: <conservative UX assumption made>
- A2: <conservative UX assumption made>

## Needs validation

- D1: <UX decision that requires product or architecture validation>
- D2: <UX decision that requires product or architecture validation>

## Handoff to sdd-spec-writer

### May assume
- <what sdd-spec-writer can treat as stable UX truth>

### Must not invent
- <what sdd-spec-writer should not still need to design or guess>

### Still needs to specify
- <what sdd-spec-writer must still define in the .feature>
```

---

# Section-by-section guidance

## Context

Keep this short.
Reference the Product Framing Dossier.
Do not repeat the entire framing here.

## In scope / Out of scope

Be explicit about what interaction flows are covered.
Out-of-scope is especially important to prevent scope drift from designers and builders.

## User journey

This is one of the most important sections.

Cover at minimum:
- the nominal path (everything goes right)
- the main failure path (validation error, permission refusal, or system issue)

Keep steps short and actor-action-outcome format.

## Screen structure

For each distinct screen or view in the flow:
- describe it independently
- do not assume the reader knows the navigation from context
- identify entry trigger clearly — this is what sdd-spec-writer will use as the triggering action in the feature

## UI states

States are critical for sdd-spec-writer.
If the behavior of the feature changes based on the entity state (draft, active, archived, locked...), make those states and their visible differences explicit here.

## Form structure

Forms are dense with specification logic.
Field-by-field description prevents sdd-spec-writer from inventing validation rules.

## Navigation flow

Not every flow needs a diagram.
A clear textual navigation flow is sufficient.

## UX edge cases

Think about:
- empty state (no data yet)
- maximum items or limits
- form submitted twice
- interrupted flow (user navigates away mid-flow)
- connection or system error mid-flow

Not every flow has all edge cases, but they should be consciously evaluated.

## Needs validation

This section is not a weakness. It is a feature.
An honest UX Design Note that surfaces unresolved decisions is more useful than a confident-looking but invented one.

## Handoff to sdd-spec-writer

This section directly enables the next skill.
Be specific about what sdd-spec-writer may now assume.
Be specific about what it must still define in the `.feature` (behavior, rules, error wording, etc.).

---

# When to use a lighter version

Use a full template when:
- the flow involves multiple screens
- there are meaningful UI states
- forms are present
- permissions affect visibility
- edge cases are likely to matter

Use a lighter version when:
- the flow is very simple (one screen, one action)
- there are no meaningful states
- no form logic is involved

Even in lighter mode:
- keep the user journey explicit
- keep the handoff section
- keep the Needs validation section if anything is unresolved

---

# Anti-patterns

Do not produce UX Design Notes that:
- are just a list of vague screen names without content
- omit the user journey
- describe implementation instead of interaction
- skip the Needs validation section when decisions are open
- describe visual design (colors, fonts, spacing) instead of interaction structure
- re-write the Product Framing Dossier instead of designing UX
- implicitly scope-expand by adding screens not in the framing
