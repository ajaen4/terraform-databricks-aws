
######
# Amazon Lambda
######

locals {
  resource_name = format(
    "${var.function_name}-lambda-%s",
    var.tags.environment,
  )
}

resource "aws_cloudwatch_log_group" "this" {
  count = var.create_lambda ? 1 : 0

  name              = "/aws/lambda/${local.resource_name}"
  retention_in_days = var.retention_in_days
  kms_key_id        = var.kms_key_arn

  tags = merge(
    var.tags,
    {
      "resource_name" = local.resource_name,
      "resource_type" = "cloudwatch_log",
    }
  )
}

resource "aws_lambda_function" "this" {
  count = var.create_lambda ? 1 : 0

  filename = var.filename

  function_name    = local.resource_name
  role             = aws_iam_role.lambda[0].arn
  handler          = var.handler
  source_code_hash = var.source_code_hash
  runtime          = var.runtime
  timeout          = var.timeout
  kms_key_arn      = var.kms_key_arn
  memory_size      = var.memory_size
  description      = var.description
  layers           = var.layers
  publish          = var.publish

  reserved_concurrent_executions = var.reserved_concurrent_executions

  dynamic "environment" {
    for_each = length(var.environment) == 0 ? [] : var.environment

    content {
      variables = environment.value
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config

    content {
      security_group_ids = lookup(vpc_config.value, "security_group_ids", null)
      subnet_ids         = lookup(vpc_config.value, "subnet_ids", null)
    }
  }

  tags = merge(
    var.tags,
    {
      "resource_name" = local.resource_name,
      "resource_type" = "lambda",
    }
  )
}

resource "aws_lambda_permission" "this" {
  count = var.create_lambda && length(var.triggers_arns) > 0 ? length(var.triggers_arns) : 0

  depends_on = [aws_lambda_function.this]

  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this[0].function_name
  principal     = var.lambda_permissions
  source_arn    = element(var.triggers_arns, count.index)
}
