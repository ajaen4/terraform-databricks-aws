
######
# aws_kms_key
######

variable "create_key" {
  description = "Controls if key should be created"
  type        = bool
  default     = true
}

variable "name" {
  description = "The display name of the alias"
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the key as viewed in AWS console"
  type        = string
  default     = ""
}

variable "key_usage" {
  description = "The intended use of the key"
  type        = string
  default     = "ENCRYPT_DECRYPT"
}

variable "policy" {
  description = "A valid KMS policy JSON document"
  type        = string
  default     = null
}

variable "deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource"
  type        = number
  default     = 30
}

variable "is_enabled" {
  description = "Should be false to indicates that the key is disabled"
  type        = bool
  default     = true
}

variable "enable_key_rotation" {
  description = "Should be true to indicates that the key rotation is enabled"
  type        = bool
  default     = false
}

######
# aws_kms_external_key
######

variable "external_kms_key" {
  description = "Controls if external key should be created"
  type        = bool
  default     = false
}

variable "key_material_base64" {
  description = "Base64 encoded 256-bit symmetric encryption key material to import"
  type        = string
  default     = null
}

variable "enabled" {
  description = "Should be false to indicates that the key is disabled"
  type        = bool
  default     = true
}

variable "valid_to" {
  description = "Time at which the imported key material expires"
  type        = string
  default     = null
}

######
# Tags
######

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}
