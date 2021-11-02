
module "databricks_management" {
  source = "./modules/databricks-management"

  providers = {
    databricks = databricks.token_auth
  }

  depends_on = [module.databricks_provisioning]

}