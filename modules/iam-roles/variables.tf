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