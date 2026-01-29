
# Lab 20 — Policy Hardening: Expand Guardrails without Breaking Teams

## Scenario
Governance wants stronger controls: required Name tag, no wildcard IAM, and no public access patterns. You must expand policy safely.

## Outcomes
- Add new policy rules
- Roll out policy without blocking all teams
- Provide remediation guidance

## Timebox
- Beginner: 90–150 minutes
- Experienced: 45–90 minutes

## Steps

1. Add a new policy rule requiring `Name` tag for taggable resources.
2. Add/enable IAM wildcard policy checks (if not already).
3. Run CI and fix any failures in labs/modules.
4. Write a remediation guide: “How to fix policy failures”.
5. Explain how you would phase these in (warn-only vs deny).


## Deliverables

- Updated policy files
- CI green after changes
- Remediation guide doc


## Grading rubric

Pass if:
- Policy adds value without chaos
- Learner can explain phased rollout strategy
