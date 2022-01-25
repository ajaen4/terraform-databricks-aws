variable "aws_region" {
  type = string
}

variable "workspace_name" {
  type = string
}

variable "customer_managed_vpc" {
  description = "configuration for the vpc that will be deployed to host the Databricks cluster"
  type        = any
}

variable "databricks_pss_param_path" {
  description = "ssm string parameter with the databricks account password"
  type        = string
}

variable "databricks_acc_username_param_path" {
  description = "ssm array parameter path with the databricks account and username, in that order"
  type        = string
}

variable "prefix" {
  type    = string
  default = "cm-vpc"
}

variable "tags" {
  description = "tags that will be added to all the resources created"
  type        = map(string)
}

variable "aws_datalake_kms" {
  description = "configuration for the encryption key used to encrypt the datalake buckets"
  type        = map(string)
}

variable "aws_baseline_kms" {
  description = "encryption key used to encrypt logging buckets"
  type        = map(string)
}

variable "aws_baseline_s3_logging" {
  description = "configuration for the logging buckets (vpc flow logs, etc...)"
  type        = any
}

variable "aws_databricks_logs_s3" {
  description = "configuration for the Databricks logging buckets (cluster, billing and audit logs)"
  type        = any
}

variable "aws_root_s3" {
  description = "configuration for the root bucket"
  type        = any
}

variable "aws_datalake_s3_raw" {
  description = "configuration for the datalake raw bucket"
  type        = any
}

variable "aws_datalake_s3_prepared" {
  description = "configuration for the datalake prepared bucket"
  type        = any
}

variable "aws_datalake_s3_trusted" {
  description = "configuration for the datalake trusted bucket"
  type        = any
}

variable "cluster_config" {
  description = "configuration for the Databricks cluster"
  type        = any
}

variable "dbfs_client_side_enc" {
  description = "set to true to enable client side encryption on the DBFS"
  type        = string
}

variable "datalake_client_side_enc" {
  description = "set to true to enable client side encryption on the datalake buckets (raw, prepared and trusted)"
  type        = string
}
