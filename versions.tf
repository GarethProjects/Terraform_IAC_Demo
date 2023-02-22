# Terraform Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}

# Provider Block
provider "aws" {
  profile = "default"
  region  = var.aws_region
}
