locals {
  server_ami_id = "ami-1"
  client_ami_id = "ami-2"

  server_ami_tag = "localstack-ec2/server:${local.server_ami_id}"
  client_ami_tag = "localstack-ec2/client:${local.client_ami_id}"
}

resource "docker_image" "server" {
  name         = "alpine"
  keep_locally = true
}

resource "docker_image" "client" {
  name         = "alpine"
  keep_locally = true
}

resource "docker_tag" "server_ami" {
  source_image = docker_image.server.image_id
  target_image = local.server_ami_tag
}

resource "docker_tag" "client_ami" {
  source_image = docker_image.client.image_id
  target_image = local.client_ami_tag
}

resource "test_assertions" "server_instance_running" {
  component = "server"
  equal "running" {
    description = "Server instance is running"
    want        = "running"
    got         = module.infra.server_instance_state
  }
}

resource "test_assertions" "client_instance_running" {
  component = "client_instance"
  equal "running" {
    description = "Client instance is running"
    want        = "running"
    got         = module.infra.client_instance_state
  }
}
