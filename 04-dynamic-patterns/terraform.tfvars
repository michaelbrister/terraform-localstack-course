buckets = {
  logs = {
    force_destroy = true
    lifecycle_rules = [
      { id = "expire-old", enabled = true, prefix = "old/", expire_days = 30 }
    ]
  }
  assets = {
    force_destroy = true
    lifecycle_rules = []
  }
}
