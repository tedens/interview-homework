resource "random_string" "suffix" {
  length  = 8
  special = false
}

locals {
  name   = "Homework VPC"
  region = "us-east-2"
  tags = {
    Owner       = "TJ"
    Environment = "dev"
    Name        = "Homework"
  }
  cluster_name = "test-eks-${random_string.suffix.result}"
}

