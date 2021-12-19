module "databricks_cluster" {
  source = "./modules/databricks-cluster"

  cluster_config = var.cluster_config
  aws_region     = var.aws_baseline_account["region"]
  log_bucket_id  = module.aws_databricks_logging.s3_bucket_id

  meta_instance_profile_arn = module.iam_databricks_roles.meta_instance_profile_arn
  datalake_key_arn          = module.aws_datalake_kms.kms_arn
  logging_key_arn           = module.aws_baseline_kms.kms_arn

  tags = var.tags

  //Must have user PAT token, service ppal can't create clusters
  providers = {
    databricks = databricks.pat_token
  }

  depends_on = [module.databricks_management]

}