variable "aws_region" {
  type = string
}

variable "meta_instance_profile_arn" {
  type = string
}

variable "kms_key_arn_s3_enc" {
  type = string
}

variable "cluster_config" {
  type = any
}

variable "tags" {
  type = map(string)
}

variable "log_bucket_id" {
  type = string
}