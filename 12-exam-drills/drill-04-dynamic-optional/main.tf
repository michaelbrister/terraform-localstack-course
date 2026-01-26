variable "ttl_attribute" {
  type    = string
  default = ""
}

resource "aws_dynamodb_table" "t" {
  name         = "tf-course-drill04"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Id"

  attribute { name = "Id" type = "S" }

  # BROKEN: ttl emitted even when attribute_name is empty
  ttl {
    attribute_name = var.ttl_attribute
    enabled        = true
  }
}
