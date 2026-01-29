

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = "http://localhost:4566"
  }
}

# ---------------------------------------------------------------------------
# Scenario setup
#
# This resource block intentionally describes a bucket that already exists
# in reality but is NOT yet tracked in Terraform state.
#
# Terraform will therefore believe it needs to create it until we import it.
# ---------------------------------------------------------------------------

resource "aws_s3_bucket" "import_me" {
  bucket = "tf-course-import-demo"

  tags = {
    Name      = "tf-course-import-demo"
    ManagedBy = "terraform"
    Scenario  = "import-vs-recreate"
  }
}

output "bucket_name" {
  value       = aws_s3_bucket.import_me.bucket
  description = "Name of the S3 bucket adopted into Terraform via import"
}

