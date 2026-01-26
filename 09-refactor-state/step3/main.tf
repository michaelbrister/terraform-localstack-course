resource "aws_s3_bucket" "root_bucket" {
  bucket        = "tf-course-refactor-module-move"
  force_destroy = true
}
