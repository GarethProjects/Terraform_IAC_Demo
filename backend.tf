terraform {
  backend "s3" {
    bucket = "demo-bucket-terraform1000"
    key = "terraform/tfstate.tfstate"
    region = "us-east-1"
  }
}
