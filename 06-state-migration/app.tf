resource "aws_s3_bucket" "app" {
  bucket = "tf-course-migrate-app"
  force_destroy = true
}

output "app_bucket" { value = aws_s3_bucket.app.bucket }
