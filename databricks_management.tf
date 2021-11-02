
module "databricks_management" {
  source = "./modules/databricks-management"

  meta_role_arn = module.iam_roles.meta_role_arn
  data_read_role_arn = module.iam_roles.data_read_role_arn
  data_write_role_arn = module.iam_roles.data_write_role_arn

  providers = {
    databricks = databricks.token_auth
  }

  depends_on = [module.databricks_provisioning]

}