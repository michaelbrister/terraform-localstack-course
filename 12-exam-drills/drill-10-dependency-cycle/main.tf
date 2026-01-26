# Intentionally broken: dependency cycle via locals referencing outputs.

locals {
  bucket_name = output.bucket_name.value
}

resource "aws_s3_bucket" "x" {
  bucket        = local.bucket_name
  force_destroy = true
}

output "bucket_name" {
  value = aws_s3_bucket.x.bucket
}
