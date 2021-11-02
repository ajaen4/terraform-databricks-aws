
output "dummy_sg_id" {
  description = "The ID of the security group"
  value       = module.web.security_group_id
}

output "dummy_sg_vpc_id" {
  description = "The VPC ID"
  value       = module.web.security_group_vpc_id
}

output "dummy_sg_owner_id" {
  description = "The owner ID"
  value       = module.web.security_group_owner_id
}

output "dummy_sg_name" {
  description = "The name of the security group"
  value       = module.web.security_group_name
}

output "dummy_sg_description" {
  description = "The description of the security group"
  value       = module.web.security_group_description
}
