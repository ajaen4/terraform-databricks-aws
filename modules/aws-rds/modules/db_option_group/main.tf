
locals {
  resource_name = format(
    "${local.resource_prefix}-%s-dbopt01-%s",
    var.identifier,
    var.tags.environment,
  )
}

resource "aws_db_option_group" "this" {
  count = var.create_options ? 1 : 0

  name                     = local.resource_name
  option_group_description = "Database option group for ${var.identifier}"
  engine_name              = var.engine_name
  major_engine_version     = var.major_engine_version

  dynamic "option" {
    for_each = var.options

    content {
      option_name                    = lookup(option.value, "option_name", null)
      port                           = lookup(option.value, "port", null)
      version                        = lookup(option.value, "version", null)
      db_security_group_memberships  = lookup(option.value, "db_security_group_memberships", null)
      vpc_security_group_memberships = lookup(option.value, "vpc_security_group_memberships", null)

      dynamic "option_settings" {
        for_each = lookup(option.value, "option_settings", [])

        content {
          name  = lookup(option_settings.value, "name", null)
          value = lookup(option_settings.value, "value", null)
        }
      }
    }
  }

  tags = merge(
    var.tags,
    {
      "resource_name" = local.resource_name,
      "resource_type" = "dbopt",
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}
