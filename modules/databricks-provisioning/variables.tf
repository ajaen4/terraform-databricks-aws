variable "databricks_account_username" {
  type = string
}

variable "databricks_account_password" {
  type = string
}

variable "databricks_account_id" {
  type = string
}

variable "workspace_name" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "cross_account_role_arn" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "prefix" {
  type = string
}

variable "datalake_key_arn" {
  type = string
}

variable "datalake_key_alias_name" {
  type = string
}

variable "logging_key_arn" {
  type = string
}

variable "logging_key_alias_name" {
  type = string
}


