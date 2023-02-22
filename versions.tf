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
  profile = "arn:aws:iam::160359286381:instance-profile/JenkinsTerraformExecutionRole"
  region  = var.aws_region
}
