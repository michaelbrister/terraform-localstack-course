# Step 5 — import a bucket created out-of-band

Create bucket out-of-band:
```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://tf-course-import-me
```

Then:
```bash
terraform init
terraform import aws_s3_bucket.import_me tf-course-import-me
terraform plan
```
Expected: plan converges to configuration (no replacement).

Cleanup:
```bash
terraform destroy -auto-approve
aws --endpoint-url=http://localhost:4566 s3 rb s3://tf-course-import-me --force || true
```
