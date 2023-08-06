locals {
  localstack_port   = 4566
  localstack_url    = "http://localhost:${local.localstack_port}"
  localstack_s3_url = "http://s3.localhost.localstack.cloud:${local.localstack_port}"
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
  providers = {
    aws = aws
  }

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
    apigateway  = local.localstack_url
    cloudwatch  = local.localstack_url
    ec2         = local.localstack_url
    elasticache = local.localstack_url
    route53     = local.localstack_url
    s3          = local.localstack_s3_url
  }
}

resource "test_assertions" "private_subnets" {
  component = "private_subnets"
  equal "subnets" {
    description = "Private subnets valid"
    got         = module.vpc.private_subnets
    want        = ""
  }
}

resource "test_assertions" "public_subnets" {
  component = "public_subnets"
  equal "subnets" {
    description = "Public subnets valid"
    got         = module.vpc.public_subnets
    want        = ""
  }
}
