
provider "aws" {
  region = "eu-west-1"
}

data "aws_vpc" "default" {
  default = true
}

module "web" {
  source = "../../"

  name        = var.name
  description = var.description
  vpc_id      = data.aws_vpc.default.id

  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules

  ingress_cidr_blocks = [data.aws_vpc.default.cidr_block]

  tags = var.tags
}
