resource "test_assertions" "server_instance_running" {
  component = "server"
  equal "running" {
    description = "Server instance is running"
    got         = module.infra.server_instance_state
    want        = "running"
  }
}

resource "test_assertions" "client_instance_running" {
  component = "client_instance"
  equal "running" {
    description = "Client instance is running"
    got         = module.infra.client_instance_state
    want        = "running"
  }
}
