variable "use_localstack" {
  description = "Use localstack for AWS Emulation"
  default     = true
  type        = bool
}

locals {
  localstack_port   = 4566
  localstack_url    = "http://localhost:${local.localstack_port}"
  localstack_s3_url = "http://s3.localhost.localstack.cloud:${local.localstack_port}"
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
    localstack    = var.use_localstack
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"
    }
  }
}

provider "aws" {
  region = var.default_region

  default_tags {
    tags = local.default_tags
  }

  s3_use_path_style = var.use_localstack

  skip_credentials_validation = var.use_localstack
  skip_metadata_api_check     = var.use_localstack
  skip_requesting_account_id  = var.use_localstack

  endpoints {
    apigateway  = var.use_localstack ? local.localstack_url : null
    cloudwatch  = var.use_localstack ? local.localstack_url : null
    ec2         = var.use_localstack ? local.localstack_url : null
    elasticache = var.use_localstack ? local.localstack_url : null
    route53     = var.use_localstack ? local.localstack_url : null
    s3          = var.use_localstack ? local.localstack_s3_url : null
  }
}
