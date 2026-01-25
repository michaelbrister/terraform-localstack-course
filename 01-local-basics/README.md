# Lab 01 — Local state basics (S3)

Goal: run Terraform with **local state** and verify via LocalStack.

Commands:
```bash
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

Expected:
- `plan`: `Plan: 1 to add, 0 to change, 0 to destroy.`
- `apply`: `Apply complete! Resources: 1 added, 0 changed, 0 destroyed.`
- `terraform output`: `bucket = "tf-course-local-demo"`

Verify (optional AWS CLI):
```bash
aws --endpoint-url=http://localhost:4566 s3 ls | grep tf-course-local-demo
```
Expected: a line containing `tf-course-local-demo`

Cleanup:
```bash
terraform destroy -auto-approve
```
Expected: `Destroy complete! Resources: 1 destroyed.`
