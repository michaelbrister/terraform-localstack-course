# 11 — Terratest (Integration Tests)

Terratest validates that your Terraform code works end-to-end against LocalStack.

## What we test (high ROI)
1) Outputs exist and have expected shape
2) Resources exist in LocalStack (S3, SNS, SQS)
3) Messaging fan-out behavior (SNS publish → SQS receive)
4) No-replacement guard (plan after apply is clean)
5) Parallel safety (tests run in isolated temp dirs)

## Prereqs
- Go 1.22+
- LocalStack running:
  ```bash
  docker compose up -d
  ```
- AWS CLI installed (tests call it)

## Run locally
```bash
cd 11-terratest/test
go mod tidy
go test -v -timeout 25m
```

## CI notes
CI should not depend on shared remote state keys. Tests copy Terraform dirs to temp locations for isolation.
