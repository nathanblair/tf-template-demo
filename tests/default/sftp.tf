resource "test_assertions" "sftp_enabled" {
  component = "sftp"
  equal "enabled" {
    description = "SFTP is enabled"
    want        = ["SFTP"]
    got         = flatten(module.infra.transfer_protocols)
  }
}

resource "test_assertions" "sftp_endpoint" {
  component = "sftp"
  check "endpoint" {
    description = "SFTP has an endpoint"
    condition   = can(regex("[a-z]+.server.transfer.${local.default_region}.amazonaws.com", module.infra.transfer_endpoint))
  }
}
