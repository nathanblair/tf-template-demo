module "infra" {
  source = "../.."

  name    = "test"
  vpc_azs = ["us-west-1a"]
}
