resource "databricks_mws_credentials" "log_writer" {
  provider         = databricks.account
  account_id       = var.databricks_account_id
  credentials_name = "Usage Delivery"
  role_arn         = var.log_delivery_role_arn
}

resource "databricks_mws_storage_configurations" "log_bucket" {
  provider                   = databricks.account
  account_id                 = var.databricks_account_id
  storage_configuration_name = "Billable and Audit Logs"
  bucket_name                = var.log_s3_bucket_id
}

resource "databricks_mws_log_delivery" "billable_logs" {
  provider                 = databricks.account
  account_id               = var.databricks_account_id
  credentials_id           = databricks_mws_credentials.log_writer.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.log_bucket.storage_configuration_id
  delivery_path_prefix     = "billable-usage"
  config_name              = "Billable Logs"
  log_type                 = "BILLABLE_USAGE"
  output_format            = "CSV"
}

resource "databricks_mws_log_delivery" "audit_logs" {
  provider                 = databricks.account
  account_id               = var.databricks_account_id
  credentials_id           = databricks_mws_credentials.log_writer.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.log_bucket.storage_configuration_id
  delivery_path_prefix     = "audit-logs"
  config_name              = "Audit Logs"
  log_type                 = "AUDIT_LOGS"
  output_format            = "JSON"
}