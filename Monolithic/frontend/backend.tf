terraform {
  backend "s3" {
    bucket = "terraform-234567"
    key     = "state-files/terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}
