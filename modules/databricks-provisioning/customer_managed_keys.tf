resource "databricks_mws_customer_managed_keys" "storage" {
  provider   = databricks.mws
  account_id = var.databricks_account_id
  aws_key_info {
    key_arn   = var.datalake_key_arn
    key_alias = var.datalake_key_alias_name
  }
  use_cases = ["STORAGE"]
}

resource "databricks_mws_customer_managed_keys" "logging" {
  provider   = databricks.mws
  account_id = var.databricks_account_id
  aws_key_info {
    key_arn   = var.logging_key_arn
    key_alias = var.logging_key_alias_name
  }
  use_cases = ["STORAGE"]
}
