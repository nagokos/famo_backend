provider "aws" {
  profile = "develop"
  region = "ap-northeast-1"
}

terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket = "tfstate-terraform-dev"
    region = "ap-northeast-1"
    profile = "develop"
    key = "terraform.tfstate"
    encrypt = true
  }
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "tfstate-terraform-dev"
  versioning {
    enabled = true
  }
}