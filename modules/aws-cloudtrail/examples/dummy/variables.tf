
variable "name" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "enable_logging" {
  description = "fixture"
  type        = bool
  default     = false
}

variable "include_global_service_events" {
  description = "fixture"
  type        = bool
  default     = false
}

variable "is_multi_region_trail" {
  description = "fixture"
  type        = bool
  default     = false
}

variable "enable_log_file_validation" {
  description = "fixture"
  type        = bool
  default     = false
}

######
# Tags
######

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
