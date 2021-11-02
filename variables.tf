variable "aws_baseline_account" {
  type = map(string)
}

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

variable "workspace_url" {
  type = string
}

variable "customer_managed_vpc" {
  type = any
}

variable "prefix" {
  type    = string
  default = "cm-vpc"
}

variable "tags" {
  type = map(string)
}
