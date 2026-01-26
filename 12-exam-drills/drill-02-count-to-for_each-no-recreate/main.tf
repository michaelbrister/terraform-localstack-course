resource "aws_s3_bucket" "b" {
  count         = length(var.names)
  bucket        = "tf-course-drill02-${var.names[count.index]}"
  force_destroy = true
}

output "buckets" {
  value = [for x in aws_s3_bucket.b : x.bucket]
}
