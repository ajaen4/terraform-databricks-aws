output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "account_region" {
  value = data.aws_region.current.name
}

output "vpc_id" {
  description = "The ID of the Customer Managed VPC"
  value       = module.customer_managed_vpc.vpc_id
}

output "def_sg_id" {
  description = "The ID of the Def SG Id"
  value       = module.customer_managed_vpc.default_security_group_id
}

output "databricks_user" {
  value = module.databricks_management.current_user
}

output "databricks_spark_version" {
  value = module.databricks_management.databricks_spark_version
}

output "databricks_node_type" {
  value = module.databricks_management.databricks_node_type
}