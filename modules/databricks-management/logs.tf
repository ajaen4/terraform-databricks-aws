data "databricks_aws_assume_role_policy" "logdelivery" {
  provider         = databricks.service_ppal
  external_id      = var.databricks_account_id
  for_log_delivery = true
}

resource "aws_iam_role" "logdelivery" {
  name               = "${var.prefix}-logdelivery"
  description        = "(${var.prefix}) UsageDelivery role"
  assume_role_policy = data.databricks_aws_assume_role_policy.logdelivery.json
  tags               = var.tags
}

data "databricks_aws_bucket_policy" "logdelivery" {
  provider         = databricks.service_ppal
  full_access_role = aws_iam_role.logdelivery.arn
  bucket           = var.log_s3_bucket_id
}

resource "aws_s3_bucket_policy" "logdelivery" {
  bucket = var.log_s3_bucket_id
  policy = data.databricks_aws_bucket_policy.logdelivery.json
}

resource "databricks_mws_credentials" "log_writer" {
  provider         = databricks.account
  account_id       = var.databricks_account_id
  credentials_name = "Usage Delivery"
  role_arn         = aws_iam_role.logdelivery.arn
}

resource "databricks_mws_storage_configurations" "log_bucket" {
  provider                   = databricks.account
  account_id                 = var.databricks_account_id
  storage_configuration_name = "Usage Logs"
  bucket_name                = var.log_s3_bucket_id
}

resource "databricks_mws_log_delivery" "usage_logs" {
  provider                 = databricks.account
  account_id               = var.databricks_account_id
  credentials_id           = databricks_mws_credentials.log_writer.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.log_bucket.storage_configuration_id
  delivery_path_prefix     = "billable-usage"
  config_name              = "Usage Logs"
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