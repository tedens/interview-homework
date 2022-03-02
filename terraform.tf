terraform {
  required_version = "~> 1.0.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.74.3"
    }
  }

  # Remote s3 storage vs local
  backend "s3" {
    bucket = "tj-homework"
    key    = "state/"
    region = "us-east-2"
  }
}