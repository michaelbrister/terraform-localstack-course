# Lab 02 — Variables, locals, outputs, validation

Commands:
```bash
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
terraform output
```

Expected:
- output includes `tf-course-dev-app`

Try validation failure:
```bash
terraform apply -auto-approve -var env=qa
```
Expected: error `env must be dev, stage, or prod`

Cleanup:
```bash
terraform destroy -auto-approve
```
