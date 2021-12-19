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

output "dbfs_client_side_enc" {
  description = "Enable client side encryption for Databricks File System"
  value = var.dbfs_client_side_enc
}

output "datalake_client_side_enc" {
  description = "Enable client side encryption for Datalake"
  value = var.datalake_client_side_enc
}