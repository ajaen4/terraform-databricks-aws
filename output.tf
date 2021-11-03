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