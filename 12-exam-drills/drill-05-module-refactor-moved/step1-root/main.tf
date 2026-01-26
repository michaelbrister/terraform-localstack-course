resource "aws_s3_bucket" "root_bucket" {
  bucket        = "tf-course-drill05"
  force_destroy = true
}
