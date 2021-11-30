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

provider "databricks" {
  alias    = "created_workspace"
  host     = module.databricks_provisioning.databricks_host
  username = var.databricks_account_username
  password = var.databricks_account_password
}

// provider with user's token auth, necessary because the service ppal
// can't create clusters or create files in dbfs
provider "databricks" {
  alias = "pat_token"
  host  = module.databricks_provisioning.databricks_host
  token = module.databricks_provisioning.pat_token
}

// provider with service ppal auth
provider "databricks" {
  alias = "service_ppal"
  host  = module.databricks_provisioning.databricks_host
  token = module.databricks_provisioning.service_ppal_token
}

