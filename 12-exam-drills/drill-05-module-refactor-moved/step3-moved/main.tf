# Step 3: Tell Terraform the resource moved (no replacement)

moved {
  from = aws_s3_bucket.root_bucket
  to   = module.b.aws_s3_bucket.this
}

module "b" {
  source = "../modules/s3_bucket"
  name   = "tf-course-drill05"
}
