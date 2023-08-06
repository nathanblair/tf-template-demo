variable "use_localstack" {
  description = "Use localstack for AWS Emulation"
  default     = true
  type        = bool
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "<6"
    }
  }
}
