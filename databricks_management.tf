
module "databricks_management" {
  source = "./modules/databricks-management"

  depends_on       = [aws_iam_role_policy.this]

  providers = {
      databricks = databricks.token_auth
  }

}