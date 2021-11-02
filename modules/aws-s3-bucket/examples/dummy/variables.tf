
variable "bucket_name" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "force_destroy" {
  description = "fixture"
  type        = bool
  default     = false
}

variable "acl" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "versioning" {
  description = "fixture"
  type        = bool
  default     = false
}

variable "sse_prevent" {
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
