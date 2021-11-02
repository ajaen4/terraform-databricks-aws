
######
# CloudWatch Cross-Account
######

variable "sharing_account" {
  description = "Controls if cloudwatch cross-account should be created"
  type        = bool
  default     = false
}

variable "cross_account_role_name" {
  description = "The name of the cloudwath cross-account role"
  type        = string
  default     = "CloudWatch-CrossAccountSharingRole"
}

variable "account_arns" {
  description = "The list of ARNs to allow monitoring accounts to view your data"
  type        = list(string)
  default     = []
}

######
# aws_cloudwatch_log_metric_filter
######

variable "create_metric_filter" {
  description = "Controls if cloudwatch metric filter should be created"
  type        = bool
  default     = false
}

variable "filter_name" {
  description = "A name for the metric filter"
  type        = string
  default     = ""
}

variable "filter_pattern" {
  description = "A valid CloudWatch Logs filter pattern for extracting metric data out of ingested log events"
  type        = string
  default     = null
}

variable "log_group_name" {
  description = "The name of the log group to associate the metric filter with"
  type        = string
  default     = null
}

variable "metric_transformation_name" {
  description = "The name of the CloudWatch metric to which the monitored log information should be published"
  type        = string
  default     = null
}

variable "metric_transformation_namespace" {
  description = "The destination namespace of the CloudWatch metric"
  type        = string
  default     = null
}

variable "metric_transformation_value" {
  description = "What to publish to the metric"
  type        = number
  default     = 1
}

variable "metric_transformation_default_value" {
  description = "The value to emit when a filter pattern does not match a log event"
  type        = string
  default     = 0
}

######
# aws_cloudwatch_metric_alarm
######

variable "create_metric_alarm" {
  description = "Controls if cloudwatch metric alarm should be created"
  type        = bool
  default     = false
}

variable "alarm_name" {
  description = "The descriptive name for the alarm"
  type        = string
  default     = ""
}

variable "comparison_operator" {
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold"
  type        = string
  default     = null
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold"
  type        = string
  default     = null
}

variable "metric_name" {
  description = "The name for the alarm's associated metric"
  type        = string
  default     = null
}

variable "namespace" {
  description = "The namespace for the alarm's associated metric"
  type        = string
  default     = null
}

variable "period" {
  description = "The period in seconds over which the specified statistic is applied"
  type        = string
  default     = null
}

variable "statistic" {
  description = "The statistic to apply to the alarm's associated metric"
  type        = string
  default     = null
}
variable "threshold" {
  description = "The value against which the specified statistic is compared"
  type        = string
  default     = null
}

variable "actions_enabled" {
  description = "Should be true to indicates whether or not actions should be executed during any changes to the alarm's state"
  type        = bool
  default     = false
}

variable "alarm_actions" {
  description = "The list of actions (ARNs) to execute when this alarm transitions"
  type        = list(string)
  default     = []
}

variable "alarm_description" {
  description = "The description for the alarm"
  type        = string
  default     = ""
}

variable "datapoints_to_alarm" {
  description = "The number of datapoints that must be breaching to trigger the alarm."
  type        = number
  default     = 1
}

variable "insufficient_data_actions" {
  description = "The list of actions (ARNs) to execute when this alarm transitions into an INSUFFICIENT_DATA state"
  type        = list(string)
  default     = []
}

variable "ok_actions" {
  description = "The list of actions (ARNs) to execute when this alarm transitions into an OK state"
  type        = list(string)
  default     = []
}

variable "unit" {
  description = "The unit for the alarm's associated metric"
  type        = string
  default     = null
}

variable "extended_statistic" {
  description = "The percentile statistic for the metric associated with the alarm"
  type        = string
  default     = null
}

variable "treat_missing_data" {
  description = "Sets how this alarm is to handle missing data points"
  type        = string
  default     = "notBreaching"
}

variable "evaluate_low_sample_count_percentiles" {
  description = "The alarm state will be ignore or evaluate during periods with too few data points to be statistically significant for alarms based on percentiles"
  type        = string
  default     = null
}

######
# aws_cloudwatch_event_rule
######

variable "create_event_rule" {
  description = "Controls if cloudwatch event rule should be created"
  type        = bool
  default     = false
}

variable "event_name" {
  description = "A name for the event rule"
  type        = string
  default     = ""
}

variable "event_schedule" {
  description = "The scheduling expression for the event rule"
  type        = string
  default     = null
}

variable "event_pattern" {
  description = "The event pattern described a JSON object"
  type        = string
  default     = null
}

variable "event_description" {
  description = "The description of the rule for the event rule"
  type        = string
  default     = null
}

variable "event_role_arn" {
  description = "The Amazon Resource Name (ARN) associated with the role that is used for target"
  type        = string
  default     = ""
}

variable "event_is_enabled" {
  description = "Should be false to indicate whether the event rule is not enabled"
  type        = bool
  default     = true
}

######
# Tags
######

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}
