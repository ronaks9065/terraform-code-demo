terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket = "s3statebackend12654"
    dynamodb_table = "state-lock"
    key    = "global/mystatefile/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.11.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}