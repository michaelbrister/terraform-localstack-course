# Drill 10 — Dependency cycle (10 min)

Run:
```bash
terraform init
terraform plan
```
Expected: cycle error.

Fix rubric:
- Remove self-referential local/output dependency.
- Replace with a static local or a variable.
Example:
```hcl
locals { bucket_name = "tf-course-drill10" }
```

Verify:
```bash
terraform plan
terraform apply -auto-approve
```

Cleanup:
```bash
terraform destroy -auto-approve
```
