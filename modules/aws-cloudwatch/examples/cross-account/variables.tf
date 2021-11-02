
variable "account_arns" {
  description = "fixture"
  type        = list(string)
  default     = []
}

######
# Tags
######

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
