variable "default_region" {
  description = "Default AWS Region"
  default     = "us-west-1"
  type        = string
}

variable "number_of_availability_zones" {
  description = "Number of availability zones to use"
  default     = 1
  type        = number
}

locals {
  # azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  availability_zones = [for each_zone in range(var.number_of_availability_zones) : "${var.default_region}${each_zone}"]
}
