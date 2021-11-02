
######
# CloudWatch Cross-Account
######

output "cloudwatch_cross_account_arn" {
  description = "The ARN of the cloudwatch cross-account role"
  value       = concat(aws_iam_role.this.*.arn, [""])[0]
}

######
# aws_cloudwatch_event_rule
######

output "cloudwatch_event_rule_arn" {
  description = "The ARN of the cloudwatch event rule"
  value       = concat(aws_cloudwatch_event_rule.this.*.arn, [""])[0]
}

output "cloudwatch_event_rule_id" {
  description = "The name of the event rule"
  value       = concat(aws_cloudwatch_event_rule.this.*.id, [""])[0]
}

######
# aws_cloudwatch_log_metric_filter
######

output "cloudwatch_log_metric_filter_id" {
  description = "The name of the metric filter"
  value       = concat(aws_cloudwatch_log_metric_filter.this.*.id, [""])[0]
}

######
# aws_cloudwatch_metric_alarm
######

output "cloudwatch_metric_alarm_arn" {
  description = "The ARN of the cloudwatch metric alarm"
  value       = concat(aws_cloudwatch_metric_alarm.this.*.arn, [""])[0]
}

output "cloudwatch_metric_alarm_id" {
  description = "The ID of the health check"
  value       = concat(aws_cloudwatch_metric_alarm.this.*.id, [""])[0]
}
