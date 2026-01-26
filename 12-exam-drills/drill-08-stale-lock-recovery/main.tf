resource "aws_s3_bucket" "x" {
  bucket        = "tf-course-drill08"
  force_destroy = true
}
