# Drill 02 — count -> for_each with zero recreation (12 min)

Goal:
- Convert `count` to `for_each` WITHOUT destroying/recreating buckets.
- Use `terraform state mv` to preserve addresses.

Run:
```bash
terraform init
terraform apply -auto-approve
```

Now reorder list in `variables.tf` default:
- ["gamma","beta","alpha"]

Then:
```bash
terraform plan
```

Expected bad plan:
- destroys/recreates due to index changes

Fix rubric:
- Use `for_each = toset(var.names)`
- Use `each.key` for naming
- Move state addresses:
  - aws_s3_bucket.b[0] -> aws_s3_bucket.b["alpha"] etc.

Cleanup:
```bash
terraform destroy -auto-approve
```
