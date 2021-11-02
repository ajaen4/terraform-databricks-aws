
######
# aws_cloudtrail
######

output "trail_id" {
  description = "The name of the trail"
  value       = concat(aws_cloudtrail.this.*.id, [""])[0]
}

output "trail_home_region" {
  description = "The region in which the trail was created"
  value       = concat(aws_cloudtrail.this.*.home_region, [""])[0]
}

output "trail_arn" {
  description = "The Amazon Resource Name of the trail"
  value       = concat(aws_cloudtrail.this.*.arn, [""])[0]
}

######
# aws_cloudwatch_log_group
######

output "trail_iam_role_arn" {
  description = "The ARN of the IAM role used by trail"
  value       = concat(aws_iam_role.trail.*.arn, [""])[0]
}

output "trail_iam_role_name" {
  description = "The name of the IAM role used by trail"
  value       = concat(aws_iam_role.trail.*.name, [""])[0]
}

output "trail_cloudwatch_log_group" {
  description = "The ARN of the log group used by trail"
  value       = concat(aws_cloudwatch_log_group.this.*.arn, [""])[0]
}
