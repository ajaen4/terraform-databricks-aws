provider "aws" {
  region = var.aws_baseline_account["region"]
}

// initialize provider in "MWS" mode to provision new workspace
provider "databricks" {
  alias    = "mws"
  host     = "https://accounts.cloud.databricks.com"
  username = var.databricks_account_username
  password = var.databricks_account_password
}

// initialize provider in normal mode
provider "databricks" {
  // in normal scenario you won't have to give providers aliases
  alias = "created_workspace"
  host = module.databricks_provisioning.databricks_host
  username = var.databricks_account_username
  password = var.databricks_account_password
}

// initialize provider in normal mode with token auth
provider "databricks" {
  // in normal scenario you won't have to give providers aliases
  alias = "token_auth"
  host = module.databricks_provisioning.databricks_host
  token = module.databricks_provisioning.token_value
}

