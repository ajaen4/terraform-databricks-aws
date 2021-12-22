data "aws_ssm_parameter" "databricks_account_param" {
  name = var.databricks_account_param_name
}

data "aws_ssm_parameter" "databricks_account_pss" {
  name = var.databricks_pss_name
}