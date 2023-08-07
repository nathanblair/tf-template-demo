variable "enable_sftp" {
  description = "Enable sftp"
  default     = true
  type        = bool
}

resource "aws_transfer_server" "sftp" {
  # count     = var.enable_sftp ? 1 : 0
  protocols = ["SFTP"]
}

output "transfer_protocols" {
  value = aws_transfer_server.sftp.protocols
}
output "transfer_endpoint" {
  value = aws_transfer_server.sftp.endpoint
}
