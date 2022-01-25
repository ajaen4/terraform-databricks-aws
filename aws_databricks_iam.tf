module "iam_databricks_roles" {
  source = "./modules/aws-databricks-iam-roles"

  prefix                = var.prefix
  tags                  = var.tags
  databricks_account_id = local.databricks_account_id

  s3_root_bucket_arn           = module.aws_root_s3.s3_bucket_arn
  s3_data_bucket_arn           = module.aws_datalake_s3_raw.s3_bucket_arn
  s3_databricks_log_bucket_arn = module.aws_databricks_logging.s3_bucket_arn

  aws_region     = var.aws_baseline_account["region"]
  aws_account_id = data.aws_caller_identity.current.account_id
  vpc_id         = module.customer_managed_vpc.vpc_id

  providers = {
    databricks = databricks.mws
  }

}