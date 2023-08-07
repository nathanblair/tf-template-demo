locals {
  domain_name = "test.com"
  vpc_azs     = ["us-west-1a"]
}

module "infra" {
  source = "../.."

  domain_name = local.domain_name
  vpc_azs     = local.vpc_azs
  server_ami  = local.server_ami_id
  client_ami  = local.client_ami_id
}
