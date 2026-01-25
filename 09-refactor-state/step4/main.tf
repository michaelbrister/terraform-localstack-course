moved {
  from = aws_s3_bucket.root_bucket
  to   = module.bucket.aws_s3_bucket.this
}

module "bucket" {
  source = "../modules/s3_bucket"
  name   = "tf-course-refactor-module-move"
}
