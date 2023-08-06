variable "default_region" {
  description = "Default AWS Region"
  type        = string
}

variable "number_of_availability_zones" {
  description = "Number of availability zones to use"
  default     = 1
  type        = number
  validation {
    condition     = var.number_of_availability_zones <= 3 && var.number_of_availability_zones > 0
    error_message = "Number of Availibility Zones must be > 0 and <= 3"
  }
}

locals {
  az_map = ["a", "b", "c", ]

  availability_zones = [for each_zone in range(var.number_of_availability_zones) : "${var.default_region}${local.az_map[each_zone - 1]}"]
}
