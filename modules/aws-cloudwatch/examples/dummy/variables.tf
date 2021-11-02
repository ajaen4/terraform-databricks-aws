
variable "filter_name" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "filter_pattern" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "log_group_name" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "alarm_description" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "alarm_name" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "comparison_operator" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "evaluation_periods" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "metric_name" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "namespace" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "period" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "statistic" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "threshold" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "event_name" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "event_schedule" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "event_description" {
  description = "fixture"
  type        = string
  default     = ""
}

######
# Tags
######

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
