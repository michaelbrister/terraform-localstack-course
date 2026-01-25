terraform {
  backend "s3" {
    bucket                      = "tf-course-backend-prod"
    key                         = "live/prod/terraform.tfstate"
    region                      = "us-east-1"
    endpoint                    = "http://localhost:4566"
    dynamodb_table              = "tf-course-lock-prod"
    skip_credentials_validation = true
    skip_requesting_account_id  = true
  }
}
