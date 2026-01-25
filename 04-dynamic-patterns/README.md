# Lab 04 — dynamic blocks (S3 lifecycle rules with optional nested blocks)

Teaches:
- conditional resources via filtered `for_each`
- `dynamic` blocks with optional nested sub-blocks

Run:
```bash
terraform fmt
terraform init
terraform plan
terraform apply -auto-approve
```

Expected:
- 2 buckets + 1 lifecycle configuration resource = `Plan: 3 to add...`

Cleanup:
```bash
terraform destroy -auto-approve
```
