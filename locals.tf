locals {
    databricks_account_id = split(",", data.aws_ssm_parameter.databricks_account_param.value)[0]
    databricks_username = split(",", data.aws_ssm_parameter.databricks_account_param.value)[1]
    databricks_pss = data.aws_ssm_parameter.databricks_account_pss.value
}