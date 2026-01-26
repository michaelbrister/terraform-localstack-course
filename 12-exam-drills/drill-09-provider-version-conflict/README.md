# Drill 09 — Provider version conflict (8 min)

Run:
```bash
terraform init
```
Expected: error about no matching provider version.

Fix rubric:
- Change constraint to something sane like `~> 5.0` or `>= 5.0, < 6.0`
- Then:
```bash
terraform init -upgrade
terraform plan
```

Cleanup:
```bash
terraform destroy -auto-approve
```
