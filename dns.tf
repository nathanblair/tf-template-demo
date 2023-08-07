variable "domain_name" {
  description = "The DNS domain name"
  type        = string
}

resource "aws_route53_zone" "main" {
  name = var.domain_name
}

output "zone_id" {
  value = aws_route53_zone.main.zone_id
}

output "zone_name" {
  value = aws_route53_zone.main.name
}

output "zone_primary_name_server" {
  value = aws_route53_zone.main.primary_name_server
}

output "zone_name_servers" {
  value = aws_route53_zone.main.name_servers
}
