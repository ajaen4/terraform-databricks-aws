
######
# aws_lambda_function
######

variable "create_lambda" {
  description = "Controls if a Lambda Function should be created"
  type        = bool
  default     = true
}

variable "function_name" {
  description = "A unique name for your Lambda Function"
  type        = string
}

variable "filename" {
  description = "The path to the function's deployment package"
  type        = string
  default     = null
}

variable "handler" {
  description = "The function entrypoint in your code"
  type        = string
}

variable "description" {
  description = "Description of what your Lambda Function does"
  type        = string
  default     = ""
}

variable "layers" {
  description = "List of Lambda Layer Version ARNs (maximum of 5)"
  type        = list(string)
  default     = []
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime"
  type        = number
  default     = 128
}

variable "runtime" {
  description = "The Lambda Function runtime"
  type        = string
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds"
  type        = number
  default     = 3
}

variable "reserved_concurrent_executions" {
  description = "The amount of reserved concurrent executions for this Lambda Function"
  type        = number
  default     = -1
}

variable "publish" {
  description = "Should be true to publish creation/change as new Lambda Function"
  type        = bool
  default     = false
}

variable "kms_key_arn" {
  description = "The ARN for the KMS encryption key"
  type        = string
  default     = null
}

variable "source_code_hash" {
  description = "Must be set to a base64-encoded SHA256 hash of the package file"
  type        = string
  default     = null
}

variable "vpc_config" {
  description = "VPC config that allow your function to access the VPC"
  type = list(object({
    security_group_ids = list(string)
    subnet_ids         = list(string)
  }))
  default = []
}

######
# aws_lambda_permission
######

variable "lambda_permissions" {
  description = "The principals who is getting the permission of trigger this Lambda Function"
  type        = string
  default     = null
}

variable "triggers_arns" {
  description = "List of ARNs to invoke your function this Lambda Function"
  type        = list(string)
  default     = []
}

######
# Optional blocks to pass through to our lambda function
######

variable "environment" {
  description = "The Lambda environment's configuration settings"
  type        = list(map(string))

  default = [
    {
      foo = "bar"
    }
  ]
}

######
# aws_cloudwatch_log_group
######

variable "retention_in_days" {
  description = "The number of days that you want to retain log events"
  type        = number
  default     = 30
}

######
# Tags
######

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}
