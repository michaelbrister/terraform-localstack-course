# Step 2 — rename with moved block (no replacement)

Run:
```bash
terraform init
terraform plan
```
Expected: `No changes.` (or at most metadata). Critically: **no destroy/create**.

Then:
```bash
terraform apply -auto-approve
```
Expected: `Resources: 0 added, 0 destroyed`.
