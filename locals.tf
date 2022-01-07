locals {
    databricks_account_id = split(",", data.aws_ssm_parameter.databricks_acc_username_param.value)[0]
    databricks_username = split(",", data.aws_ssm_parameter.databricks_acc_username_param.value)[1]
    databricks_pss = data.aws_ssm_parameter.databricks_pss_param_name.value
}