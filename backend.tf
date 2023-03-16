terraform {
  backend "s3" {
    bucket = "demo-bucket-terraform1000"
    key = "terraformDemoProject/tfstate.tfstate"
    region = "us-east-1"
  }
}
