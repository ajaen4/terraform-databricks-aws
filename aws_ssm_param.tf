data "aws_ssm_parameter" "databricks_acc_username_param" {
  name = var.databricks_acc_username_param_path
}

data "aws_ssm_parameter" "databricks_pss_param_name" {
  name = var.databricks_pss_param_path
}