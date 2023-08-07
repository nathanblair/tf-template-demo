variable "server_ami" {
  description = "AMI ID for the server instance"
  type        = string
}

variable "client_ami" {
  description = "AMI ID for the client instance"
  type        = string
}

variable "enable_server_instance" {
  description = "Enable the server instance"
  default     = true
  type        = bool
}

variable "enable_client_instance" {
  description = "Enable the client instance"
  default     = true
  type        = bool
}

resource "aws_instance" "server" {
  count         = var.enable_server_instance ? 1 : 0
  ami           = var.server_ami
  instance_type = "t3.micro"
  tags = {
    Name = "server"
  }
}

resource "aws_instance" "client" {
  count         = var.enable_client_instance ? 1 : 0
  ami           = var.client_ami
  instance_type = "t3.micro"
  tags = {
    Name = "client"
  }
}

output "server_instance_state" {
  value = var.enable_server_instance ? aws_instance.server.0.instance_state : "disabled"
}

output "client_instance_state" {
  value = var.enable_client_instance ? aws_instance.client.0.instance_state : "disabled"
}
