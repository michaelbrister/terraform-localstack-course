output "bucket" {
  value       = aws_s3_bucket.demo.bucket
  description = "Name of the S3 bucket created by this Terraform configuration"
}
