terraform {
  backend "s3" {
    encrypt = true
    bucket = "terraform-state-storage"
    region = "eu-central-1"
    key = "terraform.tfstate"
  }
}