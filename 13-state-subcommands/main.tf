resource "aws_s3_bucket" "a" {
  bucket        = "tf-course-state-a"
  force_destroy = true
}

resource "aws_s3_bucket" "b" {
  bucket        = "tf-course-state-b"
  force_destroy = true
}

output "buckets" {
  value = {
    a = aws_s3_bucket.a.bucket
    b = aws_s3_bucket.b.bucket
  }
}
