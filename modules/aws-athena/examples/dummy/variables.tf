
variable "name" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "enforce_config" {
  description = "fixture"
  type        = bool
  default     = false
}

variable "catalog_name" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "catalog_description" {
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
