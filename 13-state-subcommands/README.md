# 13 — State Subcommands Lab (list/show/mv/rm/pull)

This lab is about being **dangerous in a safe way**: state is where Terraform becomes powerful.
The Associate exam expects familiarity; professional work requires competence.

## Prereqs
- LocalStack running
- This lab uses local state (default)

## Setup
```bash
cd 13-state-subcommands
terraform init
terraform apply -auto-approve
```

Expected: creates 2 buckets and outputs their names.

---

## Exercises

### Exercise A — `terraform state list`
```bash
terraform state list
```
Expected:
- shows 2 resources (aws_s3_bucket.a and aws_s3_bucket.b)

### Exercise B — `terraform state show`
```bash
terraform state show aws_s3_bucket.a
```
Expected:
- shows attributes including bucket name

### Exercise C — `terraform state mv`
Goal: rename `aws_s3_bucket.a` to `aws_s3_bucket.alpha` without replacement.

1) Update `main.tf` to rename resource `a` -> `alpha` (code only).
2) Run:
```bash
terraform plan
```
Expected: would destroy/create (bad).

3) Fix by moving state:
```bash
terraform state mv aws_s3_bucket.a aws_s3_bucket.alpha
```
4) Re-run plan:
```bash
terraform plan
```
Expected: `No changes.`

### Exercise D — `terraform state rm` (and why it’s scary)
Goal: remove tracking without destroying infra.

```bash
terraform state rm aws_s3_bucket.b
terraform plan
```
Expected:
- Terraform now wants to create aws_s3_bucket.b again (because it no longer tracks it).

Recover by importing:
```bash
terraform import aws_s3_bucket.b tf-course-state-b
terraform plan
```
Expected: converges.

### Exercise E — `terraform state pull`
```bash
terraform state pull > pulled.tfstate
ls -l pulled.tfstate
```
Expected: file exists with JSON state content.

---

## Cleanup
```bash
terraform destroy -auto-approve
```

## Notes
- `state rm` does NOT delete the real resource. It only removes it from Terraform tracking.
- Use these commands carefully in production and always communicate changes.
