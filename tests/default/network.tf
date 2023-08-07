resource "test_assertions" "private_subnets" {
  component = "private_subnets"
  equal "subnets" {
    description = "Private subnets valid"
    want        = ["10.0.1.0/24"]
    got         = flatten(module.infra.private_subnets)
  }
}

resource "test_assertions" "public_subnets" {
  component = "public_subnets"
  equal "subnets" {
    description = "Public subnets valid"
    want        = ["10.0.101.0/24"]
    got         = flatten(module.infra.public_subnets)
  }
}
