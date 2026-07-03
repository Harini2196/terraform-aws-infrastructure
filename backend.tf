terraform {
  # Environment isolation is handled by Terraform workspaces, not by the key
  # below: the S3 backend automatically namespaces state per workspace as
  # env:/<workspace>/terraform.tfstate, so dev/staging/prod never collide.
  backend "s3" {
    bucket         = "codecloud-terraform-tfstate"
    key            = "terraform.tfstate"
    dynamodb_table = "codecloud-terraform-tfstate-lock"
    region         = "us-east-1"
  }
}
