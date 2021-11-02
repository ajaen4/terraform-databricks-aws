
######
# Amazon IAM for Lambda Function
######

data "aws_iam_policy_document" "assume_role" {
  count = var.create_lambda ? 1 : 0

  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  count = var.create_lambda ? 1 : 0

  name = format(
    "${local.resource_prefix}-%s-role01-%s",
    var.function_name,
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

data "aws_iam_policy_document" "kms" {
  count = var.kms_key_arn != null && var.create_lambda ? 1 : 0

  statement {
    sid = "AllowKMSDecrypt"

    effect = "Allow"

    actions = ["kms:Decrypt"]

    resources = [var.kms_key_arn]
  }
}

resource "aws_iam_policy" "kms" {
  count = var.kms_key_arn != null && var.create_lambda ? 1 : 0

  name = format(
    "${local.resource_prefix}-%s-policy01-%s",
    var.function_name,
    var.tags.environment,
  )

  policy = data.aws_iam_policy_document.kms.*.json
}

resource "aws_iam_role_policy_attachment" "kms" {
  count = var.kms_key_arn != null && var.create_lambda ? 1 : 0

  role       = aws_iam_role.lambda[0].id
  policy_arn = aws_iam_policy.kms[0].arn
}

resource "aws_iam_role_policy_attachment" "vpc" {
  count = var.create_lambda ? 1 : 0

  role       = aws_iam_role.lambda[0].id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}
