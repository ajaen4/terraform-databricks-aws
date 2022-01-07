variable "aws_baseline_account" {
  type = map(string)
}

variable "workspace_name" {
  type = string
}

variable "customer_managed_vpc" {
  type = any
}

variable "databricks_pss_param_path" {
  description = "ssm string parameter with the databricks account password"
  type = string
}

variable "databricks_acc_username_param_path" {
  description = "ssm array parameter path with the databricks account and username, in that order"
  type = string
}

variable "prefix" {
  type    = string
  default = "cm-vpc"
}

variable "tags" {
  type = map(string)
}

variable "aws_datalake_kms" {
  type = map(string)
}

variable "aws_baseline_kms" {
  type = map(string)
}

variable "aws_baseline_s3_logging" {
  type = any
}

variable "aws_databricks_logs_s3" {
  type = any
}

variable "aws_root_s3" {
  type = any
}

variable "aws_datalake_s3_raw" {
  type = any
}

variable "aws_datalake_s3_prepared" {
  type = any
}

variable "aws_datalake_s3_trusted" {
  type = any
}

variable "cluster_config" {
  type = any
}

variable "dbfs_client_side_enc" {
  type = string
}

variable "datalake_client_side_enc" {
  type = string
}
