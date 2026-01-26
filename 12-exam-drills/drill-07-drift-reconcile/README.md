# Drill 07 — Drift reconcile (10 min)

Run:
```bash
terraform init
terraform apply -auto-approve
```

Create drift:
```bash
aws --endpoint-url=http://localhost:4566 s3api put-bucket-tagging   --bucket tf-course-drill07   --tagging 'TagSet=[{Key=ChangedBy,Value=cli}]'
```

Then:
```bash
terraform plan
```
Expected: drift detected.

Fix: revert drift (apply) OR accept drift (update tags in code) so plan becomes clean.

Cleanup:
```bash
terraform destroy -auto-approve
```
