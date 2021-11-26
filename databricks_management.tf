module "databricks_management" {
  source = "./modules/databricks-management"

  cluster_config = var.cluster_config
  aws_region     = var.aws_baseline_account["region"]

  meta_instance_profile_arn = module.iam_roles.meta_instance_profile_arn
  kms_key_arn_s3_enc        = module.aws_datalake_kms.kms_arn

  tags = var.tags

  providers = {
    databricks = databricks.service_ppal
  }

  depends_on = [module.databricks_provisioning]

}