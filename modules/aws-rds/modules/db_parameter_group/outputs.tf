
######
# aws_db_parameter_group
######

output "db_parameter_group_id" {
  description = "The db parameter group id"
  value       = concat(aws_db_parameter_group.this.*.id, [""])[0]
}

output "db_parameter_group_arn" {
  description = "The ARN of the db parameter group"
  value       = concat(aws_db_parameter_group.this.*.arn, [""])[0]
}
