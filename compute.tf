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
  ami           = "ami-000001"
  instance_type = "t3.micro"
  tags = {
    Name = "server"
  }
}

resource "aws_instance" "client" {
  ami           = "ami-000001"
  instance_type = "t3.micro"
  tags = {
    Name = "client"
  }
}

output "server_instance_state" {
  value = aws_instance.server.instance_state
}

output "client_instance_state" {
  value = aws_instance.client.instance_state
}
