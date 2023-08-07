resource "test_assertions" "sftp_enabled" {
  component = "sftp"
  equal "enabled" {
    description = "SFTP is enabled"
    got         = module.infra.transfer_protocols
    want        = ["DOESN'T WORK"]
  }
}

resource "test_assertions" "sftp_access" {
  component = "sftp"
  equal "accessible" {
    description = "SFTP is accessible"
    got         = module.infra.transfer_endpoint
    want        = "DOESN'T WORK"
  }
}
