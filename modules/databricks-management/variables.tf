variable "aws_region" {
  type = string
}

variable "databricks_account_id" {
  type = string
}

variable "meta_instance_profile_arn" {
  type = string
}

variable "datalake_key_arn" {
  type = string
}

variable "cluster_config" {
  type = any
}

variable "log_delivery_role_arn" {
  type = string
}

variable "log_s3_bucket_id" {
  type = string
}

variable "dbfs_client_side_enc" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "prefix" {
  type = string
}