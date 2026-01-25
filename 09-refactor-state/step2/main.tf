moved {
  from = aws_s3_bucket.oldname
  to   = aws_s3_bucket.newname
}

resource "aws_s3_bucket" "newname" {
  bucket = "tf-course-refactor-oldname"
  force_destroy = true
}
