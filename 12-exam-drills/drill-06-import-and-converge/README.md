# Drill 06 — Import and converge (12 min)

Create bucket out-of-band:
```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://tf-course-drill06-import
```

Import:
```bash
terraform init
terraform import aws_s3_bucket.import_me tf-course-drill06-import
terraform plan
```

Goal: make plan converge (likely tags). Apply once if needed.

Cleanup:
```bash
terraform destroy -auto-approve
aws --endpoint-url=http://localhost:4566 s3 rb s3://tf-course-drill06-import --force || true
```
