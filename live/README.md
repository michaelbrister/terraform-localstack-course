# live/ environments

Apply an environment (after running `05-backend-bootstrap`):
```bash
cd live/dev
terraform init
terraform plan
terraform apply -auto-approve
```

Expected:
- remote backend configured (S3 + DynamoDB locking)
- resources created with names including the env

Destroy:
```bash
terraform destroy -auto-approve
```
