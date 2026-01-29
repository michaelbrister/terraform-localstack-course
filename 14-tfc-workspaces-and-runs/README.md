
# Lab 14 — Terraform Cloud Workspaces and Runs (Simulated with GitHub Actions)

## Scenario
You are moving from solo Terraform to team Terraform. You need a workflow that produces a plan on PR and only applies on approval.

## Outcomes
- Explain what a workspace/run is
- Demonstrate PR-style speculative plan (CI plan)
- Demonstrate approval-gated apply (GitHub environment)

## Timebox
- Beginner: 90–150 minutes
- Experienced: 45–90 minutes

## Steps

1. Read `docs/terraform-cloud-team-governance-guide.md` sections 2–4.
2. Confirm CI has separate jobs: lint → policy → integration.
3. Add a `workflow_dispatch` manual apply job (already in your improved CI).
4. Create a GitHub Environment named `apply` and require a reviewer.
5. Run workflow manually and observe the approval pause.
6. Explain how this mirrors Terraform Cloud: speculative plan vs apply with approval.


## Deliverables

- Screenshot or notes showing:
  - CI plan output on PR
  - manual apply job waiting for approval
  - apply executed after approval
- Short written explanation (5–10 sentences) mapping CI → Terraform Cloud concepts.


## Grading rubric

Pass if learner can:
- explain workspace/run/speculative plan
- demonstrate approval gate in GitHub Actions
- articulate why approvals reduce risk
