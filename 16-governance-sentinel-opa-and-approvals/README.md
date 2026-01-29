
# Lab 16 — Governance: Policy-as-code + Approvals (Sentinel concepts via OPA/Conftest)

## Scenario
Your org mandates tag compliance and blocks public resources. You must enforce guardrails in CI.

## Outcomes
- Explain policy-as-code and where it runs
- Demonstrate a failing policy and remediation
- Demonstrate approvals for applies

## Timebox
- Beginner: 90–150 minutes
- Experienced: 45–90 minutes

## Steps

1. Review `policy/terraform.rego` and `policy/iam.rego` (if added).
2. Intentionally break policy (remove Stack tag from one lab) and push a branch.
3. Observe CI failure in the policy job.
4. Fix the tags and observe CI pass.
5. Explain how this mirrors Sentinel policy sets in Terraform Cloud.


## Deliverables

- A PR that fails policy with explanation
- A follow-up commit that fixes and passes


## Grading rubric

Pass if:
- learner can interpret policy failure messages
- learner can fix without “disabling policy”
