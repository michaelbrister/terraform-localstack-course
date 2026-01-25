locals { prefix = "tf-course-${var.env}" }

resource "aws_s3_bucket" "b" {
  for_each      = var.buckets
  bucket        = "${local.prefix}-${each.key}-dyn"
  force_destroy = each.value.force_destroy
}

# Only create lifecycle config when rules exist
resource "aws_s3_bucket_lifecycle_configuration" "lc" {
  for_each = { for k, v in var.buckets : k => v if length(v.lifecycle_rules) > 0 }
  bucket   = aws_s3_bucket.b[each.key].id

  dynamic "rule" {
    for_each = each.value.lifecycle_rules
    content {
      id     = rule.value.id
      status = rule.value.enabled ? "Enabled" : "Disabled"

      dynamic "filter" {
        for_each = try(rule.value.prefix, null) != null ? [true] : []
        content { prefix = rule.value.prefix }
      }

      dynamic "expiration" {
        for_each = try(rule.value.expire_days, null) != null ? [true] : []
        content { days = rule.value.expire_days }
      }
    }
  }
}

output "bucket_names" {
  value = { for k, b in aws_s3_bucket.b : k => b.bucket }
}
