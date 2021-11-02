
provider "aws" {
  region = "eu-west-1"
}

resource "aws_cloudwatch_log_group" "example" {
  name = var.log_group_name
}

module "log_metric" {
  source = "../../"

  log_group_name = aws_cloudwatch_log_group.example.name

  create_metric_filter = true
  filter_name          = var.filter_name
  filter_pattern       = var.filter_pattern

  metric_transformation_name      = var.metric_name
  metric_transformation_namespace = var.namespace

  create_event_rule = true
  event_name        = var.event_name
  event_schedule    = var.event_schedule
  event_description = var.event_description

  create_metric_alarm = true
  alarm_name          = var.alarm_name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  alarm_description   = var.alarm_description

  tags = var.tags
}
