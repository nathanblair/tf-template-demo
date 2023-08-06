locals {
  localstack_url    = "http://localhost:4566"
  localstack_s3_url = "http://s3.localhost.localstack.cloud:4566"
  localstack_endpoints = {
    apigateway  = local.localstack_url
    cloudwatch  = local.localstack_url
    ec2         = local.localstack_url
    elasticache = local.localstack_url
    route53     = local.localstack_url
    s3          = local.localstack_s3_url #--This format required for s3_force_path_style = true
  }

  default_tags = {
    tf            = true
    managed       = true
    configuration = terraform.workspace
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"
    }
  }

  backend "s3" {
    region               = "us-west-1"
    bucket               = "tf-state"
    workspace_key_prefix = "workspace"
    # key    = "value"
    # dynamodb_table = "value"
  }
}

provider "aws" {
  region = var.default_region

  default_tags {
    tags = local.default_tags
  }

  s3_use_path_style = terraform.workspace != "dev"

  skip_credentials_validation = terraform.workspace == "dev"
  skip_metadata_api_check     = terraform.workspace == "dev"
  skip_requesting_account_id  = terraform.workspace == "dev"

  endpoints {
    apigateway  = terraform.workspace == "dev" ? local.localstack_url : null
    cloudwatch  = terraform.workspace == "dev" ? local.localstack_url : null
    ec2         = terraform.workspace == "dev" ? local.localstack_url : null
    elasticache = terraform.workspace == "dev" ? local.localstack_url : null
    route53     = terraform.workspace == "dev" ? local.localstack_url : null
    s3          = terraform.workspace == "dev" ? local.localstack_s3_url : null
  }
}
