# Lab 07 — Module composition (S3 + DynamoDB + SNS/SQS fanout)

Run:
```bash
terraform fmt
terraform init
terraform plan
terraform apply -auto-approve
```

Expected:
- resources created across services (S3 bucket+versioning+lifecycle, DynamoDB table+ttl, SNS topic, SQS queues + DLQ, subscriptions)
- outputs are maps

Verify (optional):
```bash
aws --endpoint-url=http://localhost:4566 s3 ls | grep tf-course-dev-logs
aws --endpoint-url=http://localhost:4566 dynamodb list-tables | jq '.TableNames[]' | grep tf-course-dev-sessions
aws --endpoint-url=http://localhost:4566 sns list-topics | jq
aws --endpoint-url=http://localhost:4566 sqs list-queues | jq
```

Cleanup:
```bash
terraform destroy -auto-approve
```
