terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.3.9"
      configuration_aliases = [
        databricks.mws,
        databricks.created_workspace
      ]
    }
  }
}