# TODO Terraform has functions for calculating CIDRs based on some of the input variables here

variable "cidr_space" {
  description = "CIDR Address Space (16, 24, 32, etc.)"
  default     = 16
  type        = number
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

locals {
  private_subnets = [for each_subnet in range(var.number_of_private_subnets) : "10.0.${each_subnet}.0/${var.cidr_private_subnet_space}"]
  public_subnets  = [for each_subnet in range(var.number_of_public_subnets) : "10.0.10${each_subnet}.0/${var.cidr_public_subnet_space}"]
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc"
  cidr = "10.0.0.0/${var.cidr_space}"

  azs             = local.availability_zones
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = false
}
