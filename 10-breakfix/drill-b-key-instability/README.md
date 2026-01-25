# Drill B — key instability (count + list reorder causes replacement)

Run:
```bash
terraform init
terraform apply -auto-approve
```
Expected: 3 buckets created.

Now change `terraform.tfvars` to reorder:
```hcl
names = ["c","b","a"]
```
Then:
```bash
terraform plan
```
Expected: Terraform wants to **destroy and recreate** because indices changed.

Fix (cert-grade):
- Replace `count` with `for_each = toset(var.names)`
- Use `each.key` for bucket naming
- Re-apply and confirm **no replacements** when ordering changes.
