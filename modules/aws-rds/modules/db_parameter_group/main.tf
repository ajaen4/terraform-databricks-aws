
locals {
  resource_name = format(
    "${local.resource_prefix}-%s-dbparam01-%s",
    var.identifier,
    var.tags.environment,
  )
}

resource "aws_db_parameter_group" "this" {
  count = var.create_parameters ? 1 : 0

  name        = local.resource_name
  description = "Database parameter group for ${var.identifier}"
  family      = var.family

  dynamic "parameter" {
    for_each = var.parameters

    content {
      name         = lookup(parameter.value, "name", null)
      value        = lookup(parameter.value, "value", null)
      apply_method = lookup(parameter.value, "apply_method", "immediate")
    }
  }

  tags = merge(
    var.tags,
    {
      "resource_name" = local.resource_name,
      "resource_type" = "dbparam",
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}
