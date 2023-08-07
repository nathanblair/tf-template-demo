resource "test_assertions" "dns" {
  component = "domain_name"
  equal "domain" {
    description = "Domain name matches"
    want        = local.domain_name
    got         = module.infra.zone_name
  }
}
