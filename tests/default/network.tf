resource "test_assertions" "private_subnets" {
  component = "private_subnets"
  equal "subnets" {
    description = "Private subnets valid"
    got         = flatten(module.infra.private_subnets)
    want        = ["10.0.1.0/24"]
  }
}

resource "test_assertions" "public_subnets" {
  component = "public_subnets"
  equal "subnets" {
    description = "Public subnets valid"
    got         = flatten(module.infra.public_subnets)
    want        = ["10.0.101.0/24"]
  }
}
