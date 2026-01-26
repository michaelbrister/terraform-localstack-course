# Drill 05 — Step 2 (move into module without replacement) (15 min)

Run:
```bash
terraform init
terraform plan
```
Expected bad plan: destroy root bucket, create module bucket.

Fix rubric:
Add moved block:
```hcl
moved {
  from = aws_s3_bucket.root_bucket
  to   = module.b.aws_s3_bucket.this
}
```

Verify: plan shows no destroy/create.

Cleanup:
```bash
terraform destroy -auto-approve
```
