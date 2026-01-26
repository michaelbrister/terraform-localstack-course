module "stack" {
  source      = "../../modules/app_stack"
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
    assets = {
      versioning      = false
      force_destroy   = true
      lifecycle_rules = []
      tags            = { Purpose = "assets" }
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
      queues = [
        { name = "worker", create_dlq = true, max_receive_count = 3 },
        { name = "audit", create_dlq = false, max_receive_count = 0 },
      ]
    }
  }
}

output "queues" { value = module.stack.queue_urls }
