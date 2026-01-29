locals {
  stack  = "tf-course"
  prefix = "${local.stack}-${var.env}"
}

resource "aws_s3_bucket" "b" {
  for_each = var.buckets
  bucket   = "${local.prefix}-${each.key}"

  tags = merge(
    {
      Environment = var.env,
      Stack       = local.stack,
      Name        = each.key
    },
    each.value.tags
  )
}

# Filtered for_each (only versioning=true)
resource "aws_s3_bucket_versioning" "v" {
  for_each = { for k, v in var.buckets : k => v if v.versioning }
  bucket   = aws_s3_bucket.b[each.key].id

  versioning_configuration {
    status = "Enabled"
  }
}
