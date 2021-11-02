
######
# aws_security_group
######

variable "create_sg" {
  description = "Controls if the security group should be created"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "The VPC ID where the security group is assigned"
  type        = string
  default     = null
}

variable "name" {
  description = "The name of the security group"
  type        = string
  default     = null
}

variable "description" {
  description = "The security group description"
  type        = string
  default     = ""
}

variable "revoke_rules_on_delete" {
  description = "Should be true to indicates that it will revoke all rules before deleting itself"
  type        = bool
  default     = false
}

variable "ingress_rules" {
  description = "List of ingress rules to create by name"
  type        = list(string)
  default     = []
}

variable "ingress_cidr_blocks" {
  description = "List of IPv4 CIDR blocks"
  type        = list(string)
  default     = []
}

variable "ingress_ipv6_cidr_blocks" {
  description = "List of IPv6 CIDR blocks"
  type        = list(string)
  default     = []
}

variable "ingress_prefix_list_ids" {
  description = "List of prefix list IDs"
  type        = list(string)
  default     = []
}

variable "egress_rules" {
  description = "List of egress rules to create by name"
  type        = list(string)
  default     = []
}

variable "egress_cidr_blocks" {
  description = "List of IPv4 CIDR blocks"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "egress_ipv6_cidr_blocks" {
  description = "List of IPv6 CIDR blocks"
  type        = list(string)
  default     = ["::/0"]
}

variable "egress_prefix_list_ids" {
  description = "List of prefix list IDs"
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
