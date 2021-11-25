module "databricks_management" {
  source = "./modules/databricks-management"

  cluster_config = var.cluster_config
  aws_region     = var.aws_baseline_account["region"]
  log_bucket_id  = module.aws_baseline_s3_logging.s3_bucket_id

  meta_instance_profile_arn = module.iam_roles.meta_instance_profile_arn
  kms_key_arn_s3_enc        = module.aws_datalake_kms.kms_arn

  tags = var.tags

  providers = {
    databricks = databricks.token_auth
  }

  depends_on = [module.databricks_provisioning]

}