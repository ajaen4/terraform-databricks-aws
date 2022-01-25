module "databricks_management" {
  source = "./modules/databricks-management"

  databricks_host       = module.databricks_provisioning.databricks_host
  databricks_account_id = local.databricks_account_id
  cluster_config        = var.cluster_config
  aws_region            = var.aws_region

  token = module.databricks_provisioning.pat_token

  meta_instance_profile_arn = module.iam_databricks_roles.meta_instance_profile_arn
  datalake_key_arn          = module.aws_datalake_kms.kms_arn
  log_s3_bucket_id          = module.aws_databricks_logging.s3_bucket_id
  log_delivery_role_arn     = module.iam_databricks_roles.log_delivery_role_arn
  dbfs_client_side_enc      = var.dbfs_client_side_enc

  read_role_arn  = module.iam_databricks_roles.s3_datalake_read_role_arn
  write_role_arn = module.iam_databricks_roles.s3_datalake_write_role_arn

  prefix = var.prefix
  tags   = var.tags

  providers = {
    databricks.account      = databricks.mws
    databricks.pat_token    = databricks.pat_token
    databricks.service_ppal = databricks.service_ppal
  }

  depends_on = [module.databricks_provisioning]

}