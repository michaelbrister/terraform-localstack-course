
# Lab 21 — Incident Recovery: Partial Apply, Lock, and State Consistency

## Scenario
A Terraform run was interrupted. The state is locked and the environment may be partially changed. You must restore safe operation.

## Outcomes
- Handle lock contention safely
- Diagnose partial apply symptoms
- Use state inspection commands
- Restore clean plan

## Timebox
- Beginner: 90–150 minutes
- Experienced: 45–90 minutes

## Steps

1. Simulate a stale lock using the lock drills (or interrupt apply mid-run in a backend-enabled directory).
2. Attempt a plan and observe lock failure.
3. Confirm no other run is active, then force-unlock.
4. Run plan and identify what is inconsistent.
5. Fix configuration/state to achieve a clean plan.
6. Write a short incident report: root cause, fix, prevention.


## Deliverables

- Steps taken to recover
- Incident report (short)
- Clean plan afterward


## Grading rubric

Pass if:
- Learner does not panic-delete state
- Learner can articulate safe unlock behavior
