module "iam_roles" {
  source = "./modules/iam-roles"

  prefix                = var.prefix
  tags                  = var.tags
  databricks_account_id = var.databricks_account_id
  s3_data_bucket_arn    = module.aws_datalake_s3_raw.s3_bucket_arn

  providers = {
    databricks = databricks.mws
  }

}