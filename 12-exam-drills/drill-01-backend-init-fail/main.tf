resource "aws_s3_bucket" "x" {
  bucket        = "tf-course-drill01"
  force_destroy = true
}
