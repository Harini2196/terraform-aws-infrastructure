terraform {
  backend "s3" {
    bucket  = "codecloud-terraform-tfstate"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
