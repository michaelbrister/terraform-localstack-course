resource "aws_s3_bucket" "demo" {
  bucket = "tf-course-local-demo"
  tags   = { Name = "local-demo" }
}

output "bucket" {
  value = aws_s3_bucket.demo.bucket
}
