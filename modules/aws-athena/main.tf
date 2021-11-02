
######
# AWS Athena Module
######

locals {
  glue_resource_name = format(
  "${local.resource_prefix}-%s-glue01-%s",
  var.name,
  var.tags.environment,
  )
  athena_workgroup_name = format(
  "${local.resource_prefix}-%s-athena01-%s",
  var.name,
  var.tags.environment,
  )
}

resource "aws_athena_workgroup" "this" {
  count = var.create_athena ? 1 : 0

  name = local.athena_workgroup_name

  description = var.workgroup_description
  state       = var.workgroup_state

  configuration {
    enforce_workgroup_configuration    = var.enforce_config
    publish_cloudwatch_metrics_enabled = var.cloudwatch_metrics

    result_configuration {
      output_location = "s3://${var.s3_bucket_name}/output/"
    }
  }

  tags = merge(
  var.tags,
  {
    "resource_name" = local.athena_workgroup_name,
    "resource_type" = "athena",
  }
  )
}

resource "aws_athena_named_query" "this" {
  for_each = {
  for key, value in var.queries :
  key => value
  }

  name        = lookup(each.value, "name", null)
  description = lookup(each.value, "description", null)
  query       = lookup(each.value, "query", null)

  database  = aws_glue_catalog_database.this[0].name
  workgroup = aws_athena_workgroup.this[0].id
}

resource "aws_glue_catalog_database" "this" {
  count = var.create_athena ? 1 : 0

  name        = var.catalog_name
  description = var.catalog_description
}

resource "aws_glue_crawler" "this" {
  count = var.create_athena ? 1 : 0

  name = local.glue_resource_name

  database_name = aws_glue_catalog_database.this[0].name
  schedule      = var.schedule != "" ? "cron(${var.schedule})" : null
  table_prefix  = var.table_prefix

  role = aws_iam_role.glue[0].arn

  s3_target {
    path       = "s3://${var.s3_bucket_name}"
    exclusions = concat(var.excluded_files, ["output**"])
  }

  tags = merge(
  var.tags,
  {
    "resource_name" = local.glue_resource_name,
    "resource_type" = "glue",
  }
  )
}