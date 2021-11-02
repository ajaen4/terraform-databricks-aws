
output "dummy_metric_alarm_arn" {
  description = "The ARN of the cloudwatch metric alarm"
  value       = module.log_metric.cloudwatch_metric_alarm_arn
}

output "dummy_metric_alarm_id" {
  description = "The ID of the health check"
  value       = module.log_metric.cloudwatch_metric_alarm_id
}

output "dummy_metric_filter_id" {
  description = "The name of the metric filter"
  value       = module.log_metric.cloudwatch_log_metric_filter_id
}

output "dummy_event_rule_arn" {
  description = "The ARN of the cloudwatch event rule"
  value       = module.log_metric.cloudwatch_event_rule_arn
}
