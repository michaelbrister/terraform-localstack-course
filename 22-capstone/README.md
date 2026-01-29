
# Lab 22 — Capstone: Team Terraform with Governance and Testing

## Scenario
Build a complete, multi-env stack with module versioning, CI gates, policy enforcement, and integration tests.

## Outcomes
- Multi-env dev/stage/prod
- Versioned module
- CI lint/policy/integration
- Messaging fan-out behavior test
- Documentation and runbooks

## Timebox
- Beginner: 90–150 minutes
- Experienced: 45–90 minutes

## Steps

1. Choose a stack:
   - Messaging: SNS → multiple SQS (DLQ optional)
   - Data: S3 + DynamoDB + tagging + lifecycle
2. Implement via modules (no copy/paste between envs).
3. Ensure policy gates pass.
4. Ensure terratest validates behavior.
5. Implement promotion: dev first, then stage, then prod.
6. Produce final deliverables (README, runbook, troubleshooting guide).


## Deliverables

- `live/dev`, `live/stage`, `live/prod` all apply cleanly
- CI is green
- Terratest includes fan-out behavior
- README explains usage
- Runbook covers lock/drift/import basics


## Grading rubric

Pass if:
- Everything is reproducible
- No unintended replacement in prod
- Governance + tests are enforced
- Documentation is clear
