module "databricks_provisioning" {
    source = "./modules/databricks-provisioning"

    security_group_ids              = [module.customer_managed_vpc.default_security_group_id]
    subnet_ids                      = module.customer_managed_vpc.private_subnets
    vpc_id                          = module.customer_managed_vpc.vpc_id

    cross_account_role_arn          = aws_iam_role.cross_account_role.arn

    databricks_account_username     = var.databricks_account_username
    databricks_account_password     = var.databricks_account_password
    databricks_account_id           = var.databricks_account_id
    workspace_name                  = var.workspace_name

    bucket_name                     = aws_s3_bucket.root_storage_bucket.bucket

    prefix                          = var.prefix
    aws_region      = var.aws_baseline_account["region"]

    depends_on       = [aws_iam_role_policy.this]

    providers = {
        databricks.mws = databricks.mws
        databricks.created_workspace = databricks.created_workspace
    }

}