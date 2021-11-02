
######
# aws_db_subnet_group
######

output "db_subnet_group_id" {
  description = "The db subnet group name"
  value       = concat(aws_db_subnet_group.this.*.id, [""])[0]
}

output "db_subnet_group_arn" {
  description = "The ARN of the db subnet group"
  value       = concat(aws_db_subnet_group.this.*.arn, [""])[0]
}
