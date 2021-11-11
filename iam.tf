module "iam_roles" {
  source = "./modules/iam-roles"

  prefix                = var.prefix
  tags                  = var.tags
  databricks_account_id = var.databricks_account_id
  s3_data_bucket_arn    = aws_s3_bucket.data_bucket.arn

  providers = {
    databricks = databricks.mws
  }

}