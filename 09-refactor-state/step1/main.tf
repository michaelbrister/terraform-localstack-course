resource "aws_s3_bucket" "oldname" {
  bucket        = "tf-course-refactor-oldname"
  force_destroy = true
}
