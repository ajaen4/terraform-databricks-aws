
######
# aws_s3_bucket
######

variable "create_s3_bucket" {
  description = "Controls if S3 bucket should be created"
  type        = bool
  default     = true
}

variable "bucket_name" {
  description = "The name to be used on S3 bucket as identifier"
  type        = string
}

variable "force_destroy" {
  description = "Should be true to destroy the bucket without error"
  type        = bool
  default     = false
}

variable "acl" {
  description = "The canned ACL to apply"
  type        = string
  default     = "private"
}

variable "versioning" {
  description = "Should be true to keep multiple variants of an object in the same bucket"
  type        = bool
  default     = false
}

variable "logging" {
  description = "Map containing access bucket logging configuration"
  type        = map(string)
  default     = {}
}

variable "grant" {
  description = "An ACL policy grant"
  type        = any
  default     = []
}

variable "sse_algorithm" {
  description = "The server-side encryption algorithm to use"
  type        = string
  default     = "AES256"
}

variable "sse_prevent" {
  description = "Should be true to prevent unencrypted objects to S3 bucket"
  type        = bool
  default     = false
}

variable "kms_master_key_arn" {
  description = "The AWS KMS master key ARN used"
  type        = string
  default     = null
}

variable "lifecycle_rule" {
  description = "A configuration of object lifecycle management"
  type        = any
  default     = []
}

######
# aws_s3_bucket_public_access_block
######

variable "block_public_acls" {
  description = "Should be true to block public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Should be true to block public bucket policies for this bucket"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Should be true to ignore public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Should be true to restrict public bucket policies for this bucket"
  type        = bool
  default     = true
}

variable "attach_deny_insecure_transport_policy" {
  description = "If no bucket policy is specified the default bucket policy should deny non-encrypted transport."
  type        = bool
  default     = false
}

######
# Tags
######

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}