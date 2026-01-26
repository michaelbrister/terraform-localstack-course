# 11 — Terratest

Terratest provides **integration tests** for this course using LocalStack.

## Prereqs
- Go 1.22+
- LocalStack running:
  ```bash
  docker compose up -d
  ```
- AWS CLI recommended (tests can optionally verify resources exist)

## Run locally
```bash
cd 11-terratest/test
go mod tidy
go test -v -timeout 25m
```

## How tests are structured
- Each test:
  1) `terraform init/apply`
  2) asserts outputs (shape + non-empty)
  3) optionally verifies existence via AWS CLI against LocalStack
  4) always `terraform destroy` in a defer

## CI notes
CI runs Terraform fmt/validate and Terratest on a service container LocalStack.
Avoid tests that depend on shared remote state keys.
