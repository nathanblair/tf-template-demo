variable "cidr_space" {
  description = "CIDR Address Space (16, 24, 32, etc.)"
  default     = 16
  type        = number
}

variable "vpc_prefix" {
  description = "VPC CIDR prefix"
  default     = "10.0.0.0"
  type        = string
}

variable "cidr_private_subnet_space" {
  description = "CIDR Address Space for private subnets (16, 24, 32, etc.)"
  default     = 24
  type        = number
}

variable "cidr_public_subnet_space" {
  description = "CIDR Address Space for public subnets (16, 24, 32, etc.)"
  default     = 24
  type        = number
}

variable "number_of_private_subnets" {
  description = "Number of availability private subnets to use"
  default     = 1
  type        = number
}

variable "number_of_public_subnets" {
  description = "Number of availability public subnets to use"
  default     = 1
  type        = number
}

variable "vpc_azs" {
  description = "List of Availability Zones for VPC resources"
  type        = list(string)
}

locals {
  cidr_block = "${var.vpc_prefix}/${var.cidr_space}"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc"
  cidr = local.cidr_block

  azs = var.vpc_azs
  private_subnets = [
    for each_subnet_index in range(var.number_of_private_subnets) :
    cidrsubnet(
      local.cidr_block,
      var.cidr_private_subnet_space - var.cidr_space,
      var.cidr_private_subnet_space,
    )
  ]
  public_subnets = [
    for each_subnet_index in range(var.number_of_public_subnets) :
    cidrsubnet(
      local.cidr_block,
      var.cidr_public_subnet_space - var.cidr_space,
      var.cidr_public_subnet_space,
    )
  ]

  enable_nat_gateway = true
  enable_vpn_gateway = false
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}
