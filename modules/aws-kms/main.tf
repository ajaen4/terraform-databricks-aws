
######
# Amazon KMS
######

locals {
  resource_name = format(
    "${local.resource_prefix}-%s-kms01-%s",
    var.name,
    var.tags.environment,
  )
}

resource "aws_kms_key" "this" {
  count = var.create_key ? 1 : 0

  description             = var.description
  key_usage               = var.key_usage
  policy                  = var.policy
  deletion_window_in_days = var.deletion_window_in_days
  is_enabled              = var.is_enabled
  enable_key_rotation     = var.enable_key_rotation

  tags = merge(
    var.tags,
    {
      "resource_name" = local.resource_name,
      "resource_type" = "kms",
    }
  )
}

resource "aws_kms_external_key" "this" {
  count = var.external_kms_key ? 1 : 0

  description             = var.description
  policy                  = var.policy
  key_material_base64     = var.key_material_base64
  deletion_window_in_days = var.deletion_window_in_days
  enabled                 = var.enabled
  valid_to                = var.valid_to

  tags = merge(
    var.tags,
    {
      "resource_name" = local.resource_name,
      "resource_type" = "kms",
    }
  )
}

resource "aws_kms_alias" "external" {
  count = var.external_kms_key ? 1 : 0

  name          = "alias/${local.resource_name}"
  target_key_id = aws_kms_external_key.this[0].id
}

resource "aws_kms_alias" "internal" {
  count = var.create_key ? 1 : 0

  name          = "alias/${local.resource_name}"
  target_key_id = aws_kms_key.this[0].id
}
