

variable "identifier" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "engine_name" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "engine_version" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "instance_class" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "allocated_storage" {
  description = "fixture"
  type        = number
  default     = -1
}

variable "storage_encrypted" {
  description = "fixture"
  type        = bool
  default     = false
}

variable "name" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "username" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "password" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "port" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "maintenance_window" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "backup_window" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "backup_retention_period" {
  description = "fixture"
  type        = number
  default     = -1
}

variable "skip_final_snapshot" {
  description = "fixture"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "fixture"
  type        = bool
  default     = false
}

variable "enabled_cloudwatch_logs_exports" {
  description = "fixture"
  type        = list(string)
  default     = []
}

variable "family" {
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
