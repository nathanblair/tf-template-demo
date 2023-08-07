resource "test_assertions" "dns" {
  component = "domain_name"
  equal "domain" {
    description = "Domain name matches"
    got         = module.infra.zone_name
    want        = local.domain_name
  }
}
