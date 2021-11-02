
######
# aws_lambda_function
######

output "lambda_arn" {
  description = "The ARN of the Lambda Function"
  value       = concat(aws_lambda_function.this.*.arn, [""])[0]
}

output "lambda_name" {
  description = "The name of the Lambda Function"
  value       = concat(aws_lambda_function.this.*.function_name, [""])[0]
}

output "lambda_qualified_arn" {
  description = "The ARN of the Lambda Function version"
  value       = concat(aws_lambda_function.this.*.qualified_arn, [""])[0]
}

output "lambda_invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway"
  value       = concat(aws_lambda_function.this.*.invoke_arn, [""])[0]
}

output "lambda_last_modified" {
  description = "The date Lambda Function was last modified"
  value       = concat(aws_lambda_function.this.*.last_modified, [""])[0]
}

output "lambda_version" {
  description = "Latest published version of the Lambda Function"
  value       = concat(aws_lambda_function.this.*.version, [""])[0]
}

output "lambda_source_code_size" {
  description = "The size in bytes of the Lambda Function zip file"
  value       = concat(aws_lambda_function.this.*.source_code_size, [""])[0]
}

######
# aws_cloudwatch_log_group
######

output "lambda_iam_role_arn" {
  description = "The ARN of the IAM role used by Lambda Function"
  value       = concat(aws_iam_role.lambda.*.arn, [""])[0]
}

output "lambda_iam_role_name" {
  description = "The name of the IAM role used by Lambda Function"
  value       = concat(aws_iam_role.lambda.*.name, [""])[0]
}

output "lambda_cloudwatch_log_group" {
  description = "The ARN of the log group used by Lambda Function"
  value       = concat(aws_cloudwatch_log_group.this.*.arn, [""])[0]
}
