terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.3.9"
      configuration_aliases = [
        databricks.account,
        databricks.pat_token,
        databricks.service_ppal
      ]
    }
  }
}