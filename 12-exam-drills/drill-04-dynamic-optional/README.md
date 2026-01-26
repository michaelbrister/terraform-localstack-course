# Drill 04 — dynamic optional nested block (8 min)

Goal:
- Only create TTL block if ttl_attribute != ""

Run:
```bash
terraform init
terraform plan
```

Fix rubric:
- Use `dynamic "ttl"` with conditional for_each:
  - `for_each = var.ttl_attribute != "" ? [1] : []`

Verify:
```bash
terraform apply -auto-approve
terraform apply -auto-approve -var ttl_attribute=ExpiresAt
```

Cleanup:
```bash
terraform destroy -auto-approve
```
