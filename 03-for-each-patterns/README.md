# Lab 03 — for_each patterns (simple + filtered)

This lab teaches:
- `for_each` over a map(object(...))
- Filtered `for_each` for conditional resources

Run:
```bash
terraform fmt
terraform init
terraform plan
terraform apply -auto-approve
```

Expected:
- plan adds 3 buckets + 2 versioning resources = `Plan: 5 to add...`
- output `buckets` contains logs/assets/uploads

Verify:
```bash
aws --endpoint-url=http://localhost:4566 s3 ls | grep tf-course-dev-
```

Cleanup:
```bash
terraform destroy -auto-approve
```
