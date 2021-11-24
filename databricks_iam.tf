module "iam_roles" {
  source = "./modules/iam-roles"

  prefix                = var.prefix
  tags                  = var.tags
  databricks_account_id = var.databricks_account_id

  s3_root_bucket_arn = module.aws_root_s3.s3_bucket_arn
  s3_data_bucket_arn = module.aws_datalake_s3_raw.s3_bucket_arn

  aws_region     = var.aws_baseline_account["region"]
  aws_account_id = var.aws_baseline_account["account_id"]
  vpc_id         = module.customer_managed_vpc.vpc_id


  providers = {
    databricks = databricks.mws
  }

}