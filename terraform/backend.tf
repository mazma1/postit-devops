terraform {
  backend "s3" {
    encrypt = true
    bucket = "postit-terraform-state-storage"
    region = "eu-central-1"
    key = "terraform.tfstate"
  }
}