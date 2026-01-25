# Drill C — lock contention

Two terminals in this folder.

Terminal A:
```bash
terraform init
terraform apply
```
Wait at prompt (do not type yes).

Terminal B:
```bash
terraform init
terraform plan
```
Expected: state lock error.

Fix:
- Understand why locking exists.
- Safest resolution is to let Terminal A finish or cancel cleanly.
- Only use `terraform force-unlock` if you are certain the lock is stale.
