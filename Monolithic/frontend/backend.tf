terraform {
  backend "s3" {
    bucket  = "iac-terraform-123456"
    key     = "state/terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}
