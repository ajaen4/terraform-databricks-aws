module "databricks_management" {
  source = "./modules/databricks-management"

  meta_instance_profile_arn = module.iam_roles.meta_instance_profile_arn
  kms_key_arn_s3_enc        = module.aws_datalake_kms.kms_arn

  providers = {
    databricks = databricks.token_auth
  }

  depends_on = [module.databricks_provisioning]

}