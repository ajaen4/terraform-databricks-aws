
######
# aws_db_subnet_group
######

variable "create_subnet" {
  description = "Controls if RDS subnet should be created"
  type        = bool
  default     = true
}

variable "identifier" {
  description = "The description of the DB"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = []
}

######
# Tags
######

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}
