terraform {
  backend "s3" {
    bucket                      = "tf-course-backend-dev"
    key                         = "12-exam-drills/drill-01/terraform.tfstate"
    region                      = "us-east-1"
    endpoint                    = "http://localhost:9999" # BROKEN
    dynamodb_table              = "tf-course-lock-DEV"    # BROKEN
    skip_credentials_validation = true
    skip_requesting_account_id  = true
  }
}
