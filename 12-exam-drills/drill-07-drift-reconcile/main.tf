resource "aws_s3_bucket" "drift" {
  bucket        = "tf-course-drill07"
  force_destroy = true
  tags          = { ManagedBy = "terraform" }
}
