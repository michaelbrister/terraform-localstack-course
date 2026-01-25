locals {
  prefix = "tf-course-${var.env}"
}

resource "aws_s3_bucket" "app" {
  bucket = "${local.prefix}-app"
  tags   = { Env = var.env, Name = "app" }
}

output "bucket" {
  value = aws_s3_bucket.app.bucket
}
