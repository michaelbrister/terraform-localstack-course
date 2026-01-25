# Drill D — drift detection and reconciliation

Run:
```bash
terraform init
terraform apply -auto-approve
```
Expected: bucket created with tag.

Create drift (out-of-band):
```bash
aws --endpoint-url=http://localhost:4566 s3api put-bucket-tagging   --bucket tf-course-drift-demo   --tagging 'TagSet=[{Key=ChangedBy,Value=cli}]'
```
Then:
```bash
terraform plan
```
Expected: Terraform detects drift and wants to change tags back.

Cleanup:
```bash
terraform destroy -auto-approve
```
