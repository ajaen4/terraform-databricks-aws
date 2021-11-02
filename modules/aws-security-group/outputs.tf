
######
# aws_security_group
######

output "security_group_id" {
  description = "The ID of the security group"
  value       = concat(aws_security_group.this.*.id, [""])[0]
}

output "security_group_vpc_id" {
  description = "The VPC ID"
  value       = concat(aws_security_group.this.*.vpc_id, [""])[0]
}

output "security_group_owner_id" {
  description = "The owner ID"
  value       = concat(aws_security_group.this.*.owner_id, [""])[0]
}

output "security_group_name" {
  description = "The name of the security group"
  value       = concat(aws_security_group.this.*.name, [""])[0]
}

output "security_group_description" {
  description = "The description of the security group"
  value       = concat(aws_security_group.this.*.description, [""])[0]
}
