output "bucket_names" {
  value = { for k, b in aws_s3_bucket.buckets : k => b.bucket }
}
output "table_names" {
  value = { for k, t in aws_dynamodb_table.tables : k => t.name }
}
output "topic_arns" {
  value = { for k, t in aws_sns_topic.topic : k => t.arn }
}
output "queue_urls" {
  value = { for k, q in aws_sqs_queue.queue : k => q.url }
}
