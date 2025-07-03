terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.58.0"
    }
  }
backend "s3" {
  bucket = "eks-cluster-upgradation-remote-state"
  key = "eks-cluster-upgradation-vpc"
  region = "us-east-1"
  dynamodb_table = "eks-cluster-upgradation-locking"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

