
# Lab 15 — Team RBAC and Variable Governance (Concept + Repo Implementation)

## Scenario
Your team needs to separate who can plan vs apply, and manage shared variables consistently across environments.

## Outcomes
- Explain RBAC roles (plan vs apply)
- Demonstrate variable layering (defaults → tfvars → env vars)
- Demonstrate shared variables (tagging)

## Timebox
- Beginner: 90–150 minutes
- Experienced: 45–90 minutes

## Steps

1. Read `docs/terraform-cloud-team-governance-guide.md` sections 5–6.
2. In `live/dev`, add a variable for `owner` tag and pass it into module tags.
3. Add a `terraform.tfvars` per environment to set `owner` differently.
4. Demonstrate variable precedence by overriding with `TF_VAR_owner` locally.
5. Write a short note explaining how variable sets in TFC map to this repo’s pattern.


## Deliverables

- Updated module tags include Owner, Env, Stack
- env-specific tfvars exist for dev/stage/prod
- A short precedence demonstration (command + output)


## Grading rubric

Pass if:
- learner explains variable precedence
- applies changes safely without unintended replacement
- understands “shared variables” concept
