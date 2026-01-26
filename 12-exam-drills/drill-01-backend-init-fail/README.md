# Drill 01 — Backend init fails (10 min)

Goal:
- Fix backend config so `terraform init` succeeds.
- End with `terraform plan` working.

Run:
```bash
terraform init
```

Expected failure:
- cannot reach endpoint OR lock table not found

Fix rubric:
- endpoint must be `http://localhost:4566`
- dynamodb_table must match backend bootstrap output (e.g. `tf-course-lock-dev`)

Verify:
```bash
terraform init
terraform plan
```

Cleanup:
```bash
terraform destroy -auto-approve
```
