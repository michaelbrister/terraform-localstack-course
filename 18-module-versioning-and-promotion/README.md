
# Lab 18 — Module Versioning and Environment Promotion (Professional Pattern)

## Scenario
You have a reusable module used by dev/stage/prod. You must introduce a change and promote it safely without surprising prod.

## Outcomes
- Tag module releases
- Pin module versions in live/*
- Promote dev → stage → prod
- Write upgrade notes

## Timebox
- Beginner: 90–150 minutes
- Experienced: 45–90 minutes

## Steps

1. Create a git tag release for modules/app_stack (e.g., v0.1.0).
2. Update live/dev to use the tagged module ref.
3. Make a change in module (e.g., add required tag Name or add a queue option) and tag v0.2.0.
4. Update dev to v0.2.0 and run plan/apply.
5. Then update stage, then prod.
6. Write CHANGELOG notes for the change (breaking vs non-breaking).


## Deliverables

- Two module tags (v0.1.0, v0.2.0)
- live/dev updated first, then stage, then prod
- CHANGELOG.md describing what changed and how to upgrade


## Grading rubric

Pass if:
- Promotion order is respected
- No unintended replacement in prod
- Learner can explain why pinning avoids surprise upgrades
