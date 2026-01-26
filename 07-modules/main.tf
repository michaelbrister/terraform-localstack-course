module "stack" {
  source      = "../modules/app_stack"
  env         = "dev"
  name_prefix = "tf-course"

  buckets = {
    logs = {
      versioning    = true
      force_destroy = true
      lifecycle_rules = [
        { id = "expire-old", enabled = true, prefix = "old/", expire_days = 30 }
      ]
      tags = { Purpose = "logs" }
    }
  }

  tables = {
    sessions = {
      hash_key = "SessionId"
      attributes = [
        { name = "SessionId", type = "S" }
      ]
      ttl_attribute = "ExpiresAt"
      tags          = { Purpose = "sessions" }
    }
  }

  topics = {
    events = {
      tags = { Purpose = "events" }
      queues = [
        { name = "worker", create_dlq = true, max_receive_count = 3 },
        { name = "audit", create_dlq = false, max_receive_count = 0 },
      ]
    }
  }
}

output "buckets" { value = module.stack.bucket_names }
output "tables" { value = module.stack.table_names }
output "topics" { value = module.stack.topic_arns }
output "queues" { value = module.stack.queue_urls }
