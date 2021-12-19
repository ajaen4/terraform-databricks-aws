module "databricks_provisioning" {
  source = "./modules/databricks-provisioning"

  security_group_ids = [module.customer_managed_vpc.default_security_group_id]
  subnet_ids         = module.customer_managed_vpc.private_subnets
  vpc_id             = module.customer_managed_vpc.vpc_id

  cross_account_role_arn = module.iam_databricks_roles.cross_account_role_arn

  databricks_account_username = var.databricks_account_username
  databricks_account_password = var.databricks_account_password
  databricks_account_id       = var.databricks_account_id
  workspace_name              = var.workspace_name

  datalake_key_arn        = module.aws_datalake_kms.kms_arn
  datalake_key_alias_name = module.aws_datalake_kms.kms_alias_name
  logging_key_arn         = module.aws_baseline_kms.kms_arn
  logging_key_alias_name  = module.aws_baseline_kms.kms_alias_name

  bucket_name = module.aws_root_s3.s3_bucket_id

  token_lifetime_seconds = 1200

  prefix     = var.prefix
  aws_region = var.aws_baseline_account["region"]

  providers = {
    databricks.mws               = databricks.mws
    databricks.created_workspace = databricks.created_workspace
  }

}