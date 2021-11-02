
variable "function_name" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "handler" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "runtime" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "description" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "retention_in_days" {
  description = "fixture"
  type        = number
  default     = -1
}

variable "timeout" {
  description = "fixture"
  type        = number
  default     = -1
}

######
# Tags
######

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
