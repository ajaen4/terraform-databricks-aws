variable "prefix" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "databricks_account_id" {
  type = string
}

variable "s3_data_bucket_arn" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "aws_account_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "s3_root_bucket_arn" {
  type = string
}