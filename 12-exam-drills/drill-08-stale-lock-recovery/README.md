# Drill 08 — Stale lock recovery (10 min)

Terminal A:
```bash
terraform init
terraform apply
```
Ctrl+C after lock acquired.

Terminal B:
```bash
terraform plan
```
Expected: lock error with Lock ID.

If you're sure it's stale:
```bash
terraform force-unlock <LOCK_ID>
```

Cleanup:
```bash
terraform destroy -auto-approve
```
