
######
# Amazon IAM for CloudWatch Cross-Account
######

locals {
  cross_account_resource_name = format(
    "${local.resource_prefix}-%s-role01-%s",
    "sharing",
    var.tags.environment,
  )
}

data "aws_iam_policy_document" "assume_role" {
  count = var.sharing_account ? 1 : 0

  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = var.account_arns
    }
  }
}

resource "aws_iam_role" "this" {
  count = var.sharing_account ? 1 : 0

  assume_role_policy = data.aws_iam_policy_document.assume_role[0].json

  name = var.cross_account_role_name

  tags = merge(
    var.tags,
    {
      "resource_name" = local.cross_account_resource_name,
      "resource_type" = "iam_role",
    }
  )
}

resource "aws_iam_role_policy_attachment" "policy01" {
  count = var.sharing_account ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "policy02" {
  count = var.sharing_account ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAutomaticDashboardsAccess"
}
