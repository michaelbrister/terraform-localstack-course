# BAD PATTERN: using count with list order -> replacements when list changes
resource "aws_s3_bucket" "bad" {
  count  = length(var.names)
  bucket = "tf-course-badkeys-${var.names[count.index]}"
  force_destroy = true
}

output "buckets" {
  value = [for b in aws_s3_bucket.bad : b.bucket]
}
