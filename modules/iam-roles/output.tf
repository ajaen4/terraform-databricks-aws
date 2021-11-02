output "cross_account_role_arn" {
    value = aws_iam_role.cross_account_role.arn
}

output "meta_role_arn" {
    value = aws_iam_instance_profile.meta_instance_profile.arn
}

output "data_read_role_arn" {
    value = aws_iam_instance_profile.data_read_instance_profile.arn
}

output "data_write_role_arn" {
    value = aws_iam_instance_profile.data_write_instance_profile.arn
}