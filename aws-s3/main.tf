terraform {
  required_version = "1.10.1"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.80.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket-0001"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    Managedby = "Terraform"
  }
}