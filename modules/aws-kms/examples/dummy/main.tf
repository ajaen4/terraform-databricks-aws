
provider "aws" {
  region = "eu-west-1"
}

module "kms_key" {
  source = "../../"

  name                    = var.name
  description             = var.description
  deletion_window_in_days = 7
  enable_key_rotation     = false

  tags = var.tags
}
