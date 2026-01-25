# Drill A — invalid bucket name

Run:
```bash
terraform init
terraform plan
```
Expected: error about invalid bucket name characters.

Fix:
- remove the `'` character
- rerun plan/apply
