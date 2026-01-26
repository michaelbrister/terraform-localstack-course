resource "aws_s3_bucket" "import_me" {
  bucket        = "tf-course-import-me"
  force_destroy = true
}
