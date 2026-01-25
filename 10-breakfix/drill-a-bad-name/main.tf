resource "aws_s3_bucket" "bad" { bucket = "tf-bad-name'"; force_destroy = true }
