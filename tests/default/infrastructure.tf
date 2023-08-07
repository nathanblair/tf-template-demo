locals {
  domain_name = "test.com"
}

module "infra" {
  source = "../.."

  domain_name = local.domain_name
  vpc_azs     = ["us-west-1a"]
}
