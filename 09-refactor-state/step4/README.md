# Step 4 — move resource into module without replacement

Run:
```bash
terraform init
terraform plan
```
Expected: `No changes.` (the moved block should prevent replace).

Apply:
```bash
terraform apply -auto-approve
```
Expected: no destroy/create.
