output "buckets" {
  value       = { for k, r in aws_s3_bucket.b : k => r.bucket }
  description = ""
}
