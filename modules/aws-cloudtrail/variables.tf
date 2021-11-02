
######
# aws_cloudtrail
######

variable "create_trail" {
  description = "Controls if a trail should be created"
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the trail"
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to store logs in"
  type        = string
}

variable "s3_key_prefix" {
  description = "The name of the folder where the log files are stored"
  type        = string
  default     = null
}

variable "enable_logging" {
  description = "Should be true to enable logging for the trail"
  type        = bool
  default     = false
}

variable "include_global_service_events" {
  description = "Should be true to publish events from global services"
  type        = bool
  default     = false
}

variable "is_multi_region_trail" {
  description = "Should be true to indicate that the trail is created in all regions"
  type        = bool
  default     = false
}

variable "is_organization_trail" {
  description = "Should be true to indicate that the trail is an AWS Organizations"
  type        = bool
  default     = false
}

variable "sns_topic_name" {
  description = "The name of the Amazon SNS topic defined for notification"
  type        = string
  default     = null
}

variable "enable_log_file_validation" {
  description = "Should be true to enable log file integrity validation"
  type        = bool
  default     = false
}

variable "event_selector" {
  description = "An event selector for enabling data event logging"
  type = list(object({
    read_write_type           = string
    include_management_events = bool

    data_resource = list(object({
      type   = string
      values = list(string)
    }))
  }))
  default = []
}

variable "kms_key_arn" {
  description = "The KMS key ARN to use to encrypt the logs"
  type        = string
  default     = null
}

######
# aws_cloudwatch_log_group
######

variable "retention_in_days" {
  description = "The number of days that you want to retain log events"
  type        = number
  default     = 30
}

######
# Tags
######

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
}
