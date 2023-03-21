terraform {
  backend "s3" {
    bucket = "demo-bucket-terraform1000"
    key = "terraformDemoDay0/tfstate.tfstate"
    region = "us-east-1"
  }
}
