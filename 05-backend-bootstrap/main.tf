variable "environments" { type = set(string) default = ["dev","stage","prod"] }
locals { prefix = "tf-course" }

resource "aws_s3_bucket" "state" {
  for_each = var.environments
  bucket   = "${local.prefix}-backend-${each.key}"
  tags     = { Env = each.key, Name = "tf-backend" }
}

resource "aws_dynamodb_table" "lock" {
  for_each     = var.environments
  name         = "${local.prefix}-lock-${each.key}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute { name = "LockID" type = "S" }
  tags = { Env = each.key, Name = "tf-lock" }
}

output "backends" {
  value = { for e in var.environments : e => { bucket = aws_s3_bucket.state[e].bucket, table = aws_dynamodb_table.lock[e].name } }
}
