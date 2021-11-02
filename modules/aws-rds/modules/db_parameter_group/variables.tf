
######
# aws_db_parameter_group
######

variable "create_parameters" {
  description = "Controls if RDS db paramaters should be created"
  type        = bool
  default     = true
}

variable "identifier" {
  description = "The description of the DB"
  type        = string
  default     = null
}

variable "family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = null
}

variable "parameters" {
  description = "A list of DB parameter maps to apply"
  type        = list(map(string))
  default     = []
}

######
# Tags
######

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}
