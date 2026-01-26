resource "aws_s3_bucket" "x" {
  bucket        = "tf-course-drill09"
  force_destroy = true
}
