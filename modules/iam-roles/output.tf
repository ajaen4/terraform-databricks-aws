output "cross_account_role_arn" {
  value = aws_iam_role.cross_account_role.arn
}

output "meta_instance_profile_arn" {
  value = aws_iam_instance_profile.meta_instance_profile.arn
}