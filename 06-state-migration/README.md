# Lab 06 — Migrate local state → S3 backend (created via Terraform)

Part A: create resources with **local state**.
```bash
terraform init
terraform apply -auto-approve
```
Expected: `Resources: 1 added...` and output `tf-course-migrate-app`.

Part B: add backend config and migrate.
Create `backend.tf`:
```hcl
terraform {
  backend "s3" {
    bucket                      = "tf-course-backend-dev"
    key                         = "06-state-migration/terraform.tfstate"
    region                      = "us-east-1"
    endpoint                    = "http://localhost:4566"
    dynamodb_table              = "tf-course-lock-dev"
    skip_credentials_validation = true
    skip_requesting_account_id  = true
  }
}
```

Then migrate:
```bash
terraform init -migrate-state
terraform plan
```
Expected:
- backend configured successfully
- plan: `No changes. Your infrastructure matches the configuration.`

Lock test (two terminals):
- Terminal A: `terraform apply` (pause at prompt)
- Terminal B: `terraform plan`
Expected: lock error in Terminal B.

Verify state object exists:
```bash
aws --endpoint-url=http://localhost:4566 s3 ls s3://tf-course-backend-dev/06-state-migration/
```
Expected: `terraform.tfstate` listed.

Cleanup:
```bash
terraform destroy -auto-approve
```
