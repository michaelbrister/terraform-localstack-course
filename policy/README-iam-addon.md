# IAM policy guardrail addon

If you already run:
```bash
conftest test <plan.json> -p policy
```

…and this folder contains `terraform.rego` plus `iam.rego`,
Conftest will load both and enforce both.

To test locally:
```bash
cd 07-modules
terraform init -backend=false
terraform plan -out=tfplan
terraform show -json tfplan > tfplan.json
cd ..
conftest test 07-modules/tfplan.json -p policy
```
