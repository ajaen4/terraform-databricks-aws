
output "dummy_arn" {
  description = "The ARN of the Lambda Function"
  value       = module.hello_world.lambda_arn
}

output "dummy_name" {
  description = "The name of the Lambda Function"
  value       = module.hello_world.lambda_name
}

output "dummy_qualified_arn" {
  description = "The ARN of the Lambda Function version"
  value       = module.hello_world.lambda_qualified_arn
}

output "dummy_invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway"
  value       = module.hello_world.lambda_invoke_arn
}

output "dummy_last_modified" {
  description = "The date Lambda Function was last modified"
  value       = module.hello_world.lambda_last_modified
}

output "dummy_version" {
  description = "Latest published version of the Lambda Function"
  value       = module.hello_world.lambda_version
}

output "dummy_source_code_size" {
  description = "The size in bytes of the Lambda Function zip file"
  value       = module.hello_world.lambda_source_code_size
}

output "dummy_lambda_iam_role_arn" {
  description = "The ARN of the IAM role used by Lambda Function"
  value       = module.hello_world.lambda_iam_role_arn
}

output "dummy_iam_role_name" {
  description = "The name of the IAM role used by Lambda Function"
  value       = module.hello_world.lambda_iam_role_name
}

output "dummy_cloudwatch_log_group" {
  description = "The ARN of the log group used by Lambda Function"
  value       = module.hello_world.lambda_cloudwatch_log_group
}
