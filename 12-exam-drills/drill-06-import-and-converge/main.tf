resource "aws_s3_bucket" "import_me" {
  bucket        = "tf-course-drill06-import"
  force_destroy = true

  # Intentionally include tags that will NOT exist on the bucket
  # created out-of-band. This guarantees a post-import diff so
  # learners must converge configuration and reality.
  tags = {
    ManagedBy = "terraform"
    Env       = "dev"
    Drill     = "import-and-converge"
  }
}
