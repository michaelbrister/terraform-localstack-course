
# Lab 19 — Multi-Team Boundaries: Shared Platform vs Application Stacks

## Scenario
Your org has a platform team and app teams. You must define module boundaries and state separation so teams don’t step on each other.

## Outcomes
- Split state boundaries
- Use remote state outputs safely
- Define module ownership boundaries

## Timebox
- Beginner: 90–150 minutes
- Experienced: 45–90 minutes

## Steps

1. Create two “stacks” in the repo:
   - platform (shared): backend, shared topics/queues, tagging baseline
   - app: app-specific buckets/tables/queues
2. Ensure each stack has its own state key (or backend).
3. Use outputs from platform stack in app stack (conceptually via data sources, or by documenting how it would work with remote state).
4. Explain who owns what and how changes are coordinated.


## Deliverables

- Two directories representing platform/app stacks
- Documented ownership + state boundaries
- Outputs documented for consumption


## Grading rubric

Pass if:
- Learner avoids circular dependencies
- States are isolated
- Ownership boundaries are clear
