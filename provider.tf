terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.22.0"
    }
  }

  backend "s3" {

    bucket = aws_s3_bucket.terraform_state
    key = "global/s3/terraform.tftate"
    region = "eu-west-1"

    dynamodb_table = "value"
    encrypt = true
  }
}

provider "aws" {
  region = "eu-west-1"
}
