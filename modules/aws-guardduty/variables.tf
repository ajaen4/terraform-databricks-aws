variable "finding_publishing_frequency" {
  default     = "ONE_HOUR"
  description = "Frequency with which to publish findings (must be one of `FIFTEEN_MINUTES`, `ONE_HOUR`, `SIX_HOURS`)"
  type        = string
}

variable "guardduty_enabled" {
  default     = true
  description = "Whether or not to enable the GuardDuty service"
}

variable "notification_arn" {
  description = "SNS Topic to send notifications to"
  type        = string
}

variable "s3_destination" {
  description = "S3 bucket name"
  type        = string
}

variable "s3_path" {
  description = "S3 bucket path for guardduty"
  type        = string
}

variable "kms_key_arn" {
  description = "S3 bucket KMS ARN"
  type        = string
}

variable "tags" {
  default     = {}
  description = "User-Defined tags"
  type        = map(string)
}
