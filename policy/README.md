# Conftest Policy Checks (OPA)

These policies run against Terraform plan JSON (`terraform show -json`).

## Install conftest
- macOS: `brew install conftest`
- Linux: download a release binary

## Run locally (example)
```bash
cd 07-modules
terraform init -backend=false
terraform plan -out=tfplan
terraform show -json tfplan > tfplan.json

cd ..
conftest test 07-modules/tfplan.json -p policy
```

## What we enforce (course guardrails)
- Required tags (`Env`, `Stack`) when a resource supports tags
- S3 bucket names must start with `tf-course-`
- Disallow public S3 ACLs when bucket ACL resources exist
