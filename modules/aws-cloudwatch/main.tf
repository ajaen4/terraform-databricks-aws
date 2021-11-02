
######
# Amazon CloudWatch Module
######

locals {
  alarm_resource_name = format(
    "${local.resource_prefix}-%s-alarm01-%s",
    var.alarm_name,
    var.tags.environment,
  )
  filter_resource_name = format(
    "${local.resource_prefix}-%s-filter01-%s",
    var.filter_name,
    var.tags.environment,
  )
  event_resource_name = format(
    "${local.resource_prefix}-%s-event01-%s",
    var.event_name,
    var.tags.environment,
  )
}

resource "aws_cloudwatch_event_rule" "this" {
  count = var.create_event_rule ? 1 : 0

  name                = local.event_resource_name
  schedule_expression = var.event_schedule
  event_pattern       = var.event_pattern
  description         = var.event_description
  role_arn            = var.event_role_arn
  is_enabled          = var.event_is_enabled

  tags = merge(
    var.tags,
    {
      "resource_name" = local.event_resource_name,
      "resource_type" = "cloudwatch_event",
    }
  )
}

resource "aws_cloudwatch_log_metric_filter" "this" {
  count = var.create_metric_filter ? 1 : 0

  name           = local.filter_resource_name
  log_group_name = var.log_group_name
  pattern        = var.filter_pattern

  metric_transformation {
    name          = var.metric_transformation_name
    namespace     = var.metric_transformation_namespace
    value         = var.metric_transformation_value
    default_value = var.metric_transformation_default_value
  }
}

resource "aws_cloudwatch_metric_alarm" "this" {
  count = var.create_metric_alarm ? 1 : 0

  alarm_name        = local.alarm_resource_name
  alarm_description = var.alarm_description
  alarm_actions     = var.alarm_actions

  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  extended_statistic  = var.extended_statistic
  datapoints_to_alarm = var.datapoints_to_alarm
  threshold           = var.threshold
  unit                = var.unit
  treat_missing_data  = var.treat_missing_data

  evaluate_low_sample_count_percentiles = var.evaluate_low_sample_count_percentiles

  actions_enabled           = var.actions_enabled
  ok_actions                = var.ok_actions
  insufficient_data_actions = var.insufficient_data_actions

  tags = merge(
    var.tags,
    {
      "resource_name" = local.alarm_resource_name,
      "resource_type" = "cloudwatch_alarm",
    }
  )
}
