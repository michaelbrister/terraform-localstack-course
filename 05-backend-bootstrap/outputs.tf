output "backends" {
  value       = { for e in var.environments : e => { bucket = aws_s3_bucket.state[e].bucket, table = aws_dynamodb_table.lock[e].name } }
  description = ""
}
