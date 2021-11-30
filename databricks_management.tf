module "databricks_management" {
  source = "./modules/databricks-management"

  databricks_account_id = var.databricks_account_id
  cluster_config        = var.cluster_config
  aws_region            = var.aws_baseline_account["region"]

  meta_instance_profile_arn = module.iam_roles.meta_instance_profile_arn
  datalake_key_arn        = module.aws_datalake_kms.kms_arn
  log_s3_bucket_id          = module.aws_databricks_logging.s3_bucket_id

  prefix = var.prefix
  tags   = var.tags

  providers = {
    databricks.account      = databricks.mws
    databricks.pat_token = databricks.pat_token
    databricks.service_ppal = databricks.service_ppal
  }

  depends_on = [module.databricks_provisioning]

}