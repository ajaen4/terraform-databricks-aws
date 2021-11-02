
######
# aws_db_instance
######

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = concat(aws_db_instance.this.*.address, [""])[0]
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = concat(aws_db_instance.this.*.arn, [""])[0]
}

output "db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = concat(aws_db_instance.this.*.availability_zone, [""])[0]
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = concat(aws_db_instance.this.*.endpoint, [""])[0]
}

output "db_instance_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = concat(aws_db_instance.this.*.hosted_zone_id, [""])[0]
}

output "db_instance_id" {
  description = "The RDS instance ID"
  value       = concat(aws_db_instance.this.*.id, [""])[0]
}

output "db_instance_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = concat(aws_db_instance.this.*.resource_id, [""])[0]
}

output "db_instance_status" {
  description = "The RDS instance status"
  value       = concat(aws_db_instance.this.*.status, [""])[0]
}

output "db_instance_name" {
  description = "The database name"
  value       = concat(aws_db_instance.this.*.name, [""])[0]
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = concat(aws_db_instance.this.*.username, [""])[0]
}

output "db_instance_password" {
  description = "The database password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = concat(aws_db_instance.this.*.password, [""])[0]
}

output "db_instance_port" {
  description = "The database port"
  value       = concat(aws_db_instance.this.*.port, [""])[0]
}
