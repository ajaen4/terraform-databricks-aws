
output "dummy_db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.rds_instance.db_instance_address
}

output "dummy_db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = module.rds_instance.db_instance_arn
}

output "dummy_db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = module.rds_instance.db_instance_availability_zone
}

output "dummy_db_instance_endpoint" {
  description = "The connection endpoint"
  value       = module.rds_instance.db_instance_endpoint
}

output "dummy_db_instance_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = module.rds_instance.db_instance_hosted_zone_id
}

output "dummy_db_instance_id" {
  description = "The RDS instance ID"
  value       = module.rds_instance.db_instance_id
}

output "dummy_db_instance_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = module.rds_instance.db_instance_resource_id
}

output "dummy_db_instance_status" {
  description = "The RDS instance status"
  value       = module.rds_instance.db_instance_status
}

output "dummy_db_instance_name" {
  description = "The database name"
  value       = module.rds_instance.db_instance_name
}

output "dummy_db_instance_username" {
  description = "The master username for the database"
  value       = module.rds_instance.db_instance_username
}

output "dummy_db_instance_password" {
  description = "The database initial password"
  value       = module.rds_instance.db_instance_password
}

output "dummy_db_instance_port" {
  description = "The database port"
  value       = module.rds_instance.db_instance_port
}

output "dummy_db_subnet_group_id" {
  description = "The db subnet group name"
  value       = module.rds_instance.db_subnet_group_id
}

output "dummy_db_subnet_group_arn" {
  description = "The ARN of the db subnet group"
  value       = module.rds_instance.db_subnet_group_arn
}

output "dummy_db_parameter_group_id" {
  description = "The db parameter group id"
  value       = module.rds_instance.db_parameter_group_id
}

output "dummy_db_parameter_group_arn" {
  description = "The ARN of the db parameter group"
  value       = module.rds_instance.db_parameter_group_arn
}

output "dummy_db_option_group_id" {
  description = "The db option group id"
  value       = module.rds_instance.db_option_group_id
}

output "dummy_db_option_group_arn" {
  description = "The ARN of the db option group"
  value       = module.rds_instance.db_option_group_arn
}
