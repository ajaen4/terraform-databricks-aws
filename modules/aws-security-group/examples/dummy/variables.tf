
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

variable "ingress_rules" {
  description = "fixture"
  type        = list(string)
  default     = []
}

variable "egress_rules" {
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
