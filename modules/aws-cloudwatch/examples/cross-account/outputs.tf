
output "dummy_cloudwatch_cross_account_arn" {
  description = "The ARN of the cloudwatch cross-account role"
  value       = module.cw.cloudwatch_cross_account_arn
}
