# Drill 03 — Stable keys in flatten (10 min)

Run:
```bash
terraform init
terraform apply -auto-approve
```

Insert a queue in the middle by editing `variables.tf` default:
- queues = ["worker","metrics","audit"]

Then:
```bash
terraform plan
```

Expected bad plan:
- replacements due to index-key changes

Fix rubric:
- Make key stable: "${topic}|${qname}"
- Update for_each maps accordingly
- Use `terraform state mv` to preserve existing objects

Cleanup:
```bash
terraform destroy -auto-approve
```
