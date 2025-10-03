# Configure the AWS Provider to use instance profile credentials
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kafka = {
      source  = "Mongey/kafka"
      version = "~> 0.7"
    }
  }
}

# AWS provider will automatically use the instance profile/assumed role
provider "aws" {
  region = var.aws_region
}
