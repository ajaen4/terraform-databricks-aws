output "cross_account_role_arn" {
  value = aws_iam_role.cross_account_role.arn
}

output "meta_instance_profile_arn" {
  value = aws_iam_instance_profile.meta_instance_profile.arn
}

output "log_delivery_role_arn" {
  value = aws_iam_role.log_delivery.arn
}

output "s3_datalake_read_role_arn" {
  value = aws_iam_role.s3_datalake_read_role.arn
}

output "s3_datalake_write_role_arn" {
  value = aws_iam_role.s3_datalake_write_role.arn
}