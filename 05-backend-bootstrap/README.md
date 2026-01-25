# Lab 05 — Create dev/stage/prod backends with local state

This lab is intentionally **local state**. Do not configure a backend here.

Run:
```bash
terraform fmt
terraform init
terraform plan
terraform apply -auto-approve
```

Expected:
- `Plan: 6 to add, 0 to change, 0 to destroy.`
- Outputs include backend buckets and lock tables for dev/stage/prod.

Verify:
```bash
aws --endpoint-url=http://localhost:4566 s3 ls | grep tf-course-backend
aws --endpoint-url=http://localhost:4566 dynamodb list-tables | jq '.TableNames'
```
