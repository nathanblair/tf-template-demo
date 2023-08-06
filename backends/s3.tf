terraform {
  backend "s3" {
    region               = "us-west-1"
    bucket               = "siemens-disw-eda-infra-state"
    workspace_key_prefix = "workspace"
  }
}
