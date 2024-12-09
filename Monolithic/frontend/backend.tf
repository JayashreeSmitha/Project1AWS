terraform {
  backend "s3" {
    bucket = "terraform-2345679"
    key     = "terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}
