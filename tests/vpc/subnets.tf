locals {
  localstack_port = 4566
  localstack_url  = "http://localhost:${local.localstack_port}"
}

terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }
  }
}

module "vpc" {
  source = "../.."

  name    = "test"
  vpc_azs = ["us-west-1a"]
}

provider "aws" {
  region = "us-west-1"

  access_key = "test"
  secret_key = "test"

  s3_use_path_style = true

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ec2 = local.localstack_url
  }
}

resource "test_assertions" "private_subnets" {
  component = "private_subnets"
  equal "subnets" {
    description = "Private subnets valid"
    got         = flatten(module.vpc.private_subnets)
    want        = ["10.0.1.0/24"]
  }
}

resource "test_assertions" "public_subnets" {
  component = "public_subnets"
  equal "subnets" {
    description = "Public subnets valid"
    got         = flatten(module.vpc.public_subnets)
    want        = ["10.0.101.0/24"]
  }
}
