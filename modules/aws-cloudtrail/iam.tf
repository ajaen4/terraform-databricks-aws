
######
# Amazon IAM for CloudTrail
######

data "aws_iam_policy_document" "assume_role" {
  count = var.create_trail ? 1 : 0

  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "trail" {
  count = var.create_trail ? 1 : 0

  name = format(
    "${local.resource_prefix}-%s-role01-%s",
    var.name,
    var.tags.environment,
  )

  assume_role_policy = data.aws_iam_policy_document.assume_role[0].json

  tags = merge(
    var.tags,
    {
      "resource_name" = local.resource_name,
      "resource_type" = "iam_role",
    }
  )
}

######
# Amazon IAM for Cloudwatch
######

data "aws_iam_policy_document" "logs" {
  count = var.create_trail ? 1 : 0

  statement {
    sid = "AllowWriteToCloudWatchLogs"

    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["${aws_cloudwatch_log_group.this[0].arn}:*"]
  }
}

data "aws_iam_policy_document" "logs_kms" {
  count = var.create_trail ? 1 : 0

  source_json = data.aws_iam_policy_document.logs[0].json

  statement {
    sid = "AllowKMSDecrypt"

    effect = "Allow"

    actions = ["kms:Decrypt"]

    resources = [var.kms_key_arn]
  }
}

resource "aws_iam_role_policy" "trail" {
  count = var.create_trail ? 1 : 0

  name = format(
    "${local.resource_prefix}-%s-policy01-%s",
    var.name,
    var.tags.environment,
  )

  role = aws_iam_role.trail[0].id

  policy = element(
    concat(
      data.aws_iam_policy_document.logs.*.json,
      data.aws_iam_policy_document.logs_kms.*.json,
    ),
    0,
  )
}
