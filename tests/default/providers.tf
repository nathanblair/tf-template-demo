locals {
  localstack_port = 4566
  localstack_url  = "http://localhost:${local.localstack_port}"
  default_tags = {
    managed       = true
    managed_by    = "terraform"
    configuration = "test"
    customer      = "test"
    cost_center   = 0
  }
}

terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/guides/custom-service-endpoints#localstack
provider "aws" {
  region = "us-west-1"

  access_key = "test"
  secret_key = "test"

  default_tags {
    tags = local.default_tags
  }

  s3_use_path_style = true

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ec2 = local.localstack_url
  }
}
