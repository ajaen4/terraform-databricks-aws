
provider "aws" {
  region = "eu-west-1"
}

module "cw" {
  source = "../../"

  sharing_account = true

  account_arns = var.account_arns

  tags = var.tags
}
