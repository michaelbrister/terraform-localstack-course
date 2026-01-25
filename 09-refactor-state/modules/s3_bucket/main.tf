variable "name" { type = string }

resource "aws_s3_bucket" "this" {
  bucket = var.name
  force_destroy = true
}

output "bucket" { value = aws_s3_bucket.this.bucket }
