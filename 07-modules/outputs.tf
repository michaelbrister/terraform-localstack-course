output "buckets" {
  value       = module.stack.bucket_names
  description = ""
}

output "tables" {
  value       = module.stack.table_names
  description = ""
}

output "topics" {
  value       = module.stack.topic_arns
  description = ""
}

output "queues" {
  value       = module.stack.queue_urls
  description = ""
}
