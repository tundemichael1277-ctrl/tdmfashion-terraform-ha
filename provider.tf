terraform {
  required_version = "~>1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0"
    }
  }
  backend "s3" {
    bucket = "tdmfashion-terraform-state"
    region = "eu-west-2"
    key    = "tdmfashion-ha/terraform.tfstate"

  }
}

provider "aws" {
  region = "eu-west-2"

}