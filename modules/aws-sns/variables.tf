variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "emails" {
  description = "Email that you want to receive notifications."
  type        = list(string)
}

variable "name" {
  description = "Name of the resource "
  type        = string
}

variable "kms_master_key_id" {
  type = string
}
