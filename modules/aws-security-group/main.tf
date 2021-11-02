
######
# Amazon Security Group Module
######

locals {
  resource_name = format(
    "${local.resource_prefix}-%s-sg01-%s",
    var.name,
    var.tags.environment,
  )
}

resource "aws_security_group" "this" {
  count = var.create_sg ? 1 : 0

  description = var.description
  name        = local.resource_name
  vpc_id      = var.vpc_id

  revoke_rules_on_delete = var.revoke_rules_on_delete

  tags = merge(
    var.tags,
    {
      "resource_name" = local.resource_name,
      "resource_type" = "security_group",
    }
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name, description]
  }

}

resource "aws_security_group_rule" "ingress_rules" {
  count = var.create_sg ? length(var.ingress_rules) : 0

  security_group_id = aws_security_group.this[0].id
  type              = "ingress"

  cidr_blocks      = var.ingress_cidr_blocks
  ipv6_cidr_blocks = var.ingress_ipv6_cidr_blocks
  prefix_list_ids  = var.ingress_prefix_list_ids

  from_port   = lookup(var.rules, var.ingress_rules[count.index])[0]
  to_port     = lookup(var.rules, var.ingress_rules[count.index])[1]
  protocol    = lookup(var.rules, var.ingress_rules[count.index])[2]
  description = lookup(var.rules, var.ingress_rules[count.index])[3]
}

resource "aws_security_group_rule" "egress_rules" {
  count = var.create_sg ? length(var.egress_rules) : 0

  security_group_id = aws_security_group.this[0].id
  type              = "egress"

  cidr_blocks      = var.egress_cidr_blocks
  ipv6_cidr_blocks = var.egress_ipv6_cidr_blocks
  prefix_list_ids  = var.egress_prefix_list_ids

  from_port   = lookup(var.rules, var.egress_rules[count.index])[0]
  to_port     = lookup(var.rules, var.egress_rules[count.index])[1]
  protocol    = lookup(var.rules, var.egress_rules[count.index])[2]
  description = lookup(var.rules, var.egress_rules[count.index])[3]
}
