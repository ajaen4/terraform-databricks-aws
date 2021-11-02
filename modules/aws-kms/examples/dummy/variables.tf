
variable "name" {
  description = "fixture"
  type        = string
  default     = ""
}

variable "description" {
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
