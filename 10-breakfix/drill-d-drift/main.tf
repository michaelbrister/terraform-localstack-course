resource "aws_s3_bucket" "drift" {
  bucket = "tf-course-drift-demo"
  force_destroy = true
  tags = { ManagedBy = "terraform" }
}
