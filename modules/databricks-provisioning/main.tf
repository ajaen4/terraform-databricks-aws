resource "databricks_mws_credentials" "this" {
  provider         = databricks.mws
  account_id       = var.databricks_account_id
  role_arn         = var.cross_account_role_arn
  credentials_name = "${var.prefix}-creds"
}

resource "databricks_mws_networks" "this" {
  provider           = databricks.mws
  account_id         = var.databricks_account_id
  network_name       = "${var.prefix}-network"
  security_group_ids = var.security_group_ids
  subnet_ids         = var.subnet_ids
  vpc_id             = var.vpc_id
}

resource "databricks_mws_storage_configurations" "this" {
  provider                   = databricks.mws
  account_id                 = var.databricks_account_id
  bucket_name                = var.bucket_name
  storage_configuration_name = "${var.prefix}-storage"
}

resource "databricks_mws_workspaces" "this" {
  provider       = databricks.mws
  account_id     = var.databricks_account_id
  aws_region     = var.aws_region
  workspace_name = var.workspace_name

  credentials_id                  = databricks_mws_credentials.this.credentials_id
  storage_configuration_id        = databricks_mws_storage_configurations.this.storage_configuration_id
  network_id                      = databricks_mws_networks.this.network_id
  storage_customer_managed_key_id = databricks_mws_customer_managed_keys.storage.customer_managed_key_id
}

// create PAT token to provision entities within workspace
resource "databricks_token" "pat" {
  provider = databricks.created_workspace
  comment  = "Terraform Provisioning"
  #lifetime_seconds = 86400
}

resource "databricks_mws_customer_managed_keys" "storage" {
  provider   = databricks.mws
  account_id = var.databricks_account_id
  aws_key_info {
    key_arn   = var.storage_key_arn
    key_alias = var.storage_key_alias_name
  }
  use_cases = ["STORAGE"]
}