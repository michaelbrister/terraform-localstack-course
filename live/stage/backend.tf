terraform {
  backend "s3" {
    bucket                      = "tf-course-backend-stage"
    key                         = "live/stage/terraform.tfstate"
    region                      = "us-east-1"
    endpoint                    = "http://localhost:4566"
    dynamodb_table              = "tf-course-lock-stage"
    skip_credentials_validation = true
    skip_requesting_account_id  = true
  }
}
