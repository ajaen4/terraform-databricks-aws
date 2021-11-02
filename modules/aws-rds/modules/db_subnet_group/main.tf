
locals {
  resource_name = format(
    "${local.resource_prefix}-%s-dbnet01-%s",
    var.identifier,
    var.tags.environment,
  )
}

resource "aws_db_subnet_group" "this" {
  count = var.create_subnet ? 1 : 0

  name        = local.resource_name
  description = "Database subnet group for ${var.identifier}"
  subnet_ids  = var.subnet_ids

  tags = merge(
    var.tags,
    {
      "resource_name" = local.resource_name,
      "resource_type" = "dbnet",
    }
  )
}
