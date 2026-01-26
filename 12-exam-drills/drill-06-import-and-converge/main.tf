resource "aws_s3_bucket" "import_me" {
  bucket        = "tf-course-drill06-import"
  force_destroy = true
  tags          = { ManagedBy = "terraform" }
}
