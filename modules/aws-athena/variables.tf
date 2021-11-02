
######
# aws_athena_workgroup
######

variable "create_athena" {
  description = "Controls if athena engine should be created"
  type        = bool
  default     = true
}

variable "name" {
  description = "The workgroup's name"
  type        = string
}

variable "workgroup_description" {
  description = "The description of this workgroup"
  type        = string
  default     = null
}

variable "workgroup_state" {
  description = "The state of the workgroup"
  type        = string
  default     = "ENABLED"
}

variable "enforce_config" {
  description = "Should be true to override client-side settings"
  type        = bool
  default     = false
}

variable "cloudwatch_metrics" {
  description = "Should be true to enable CloudWatch metrics for workgroup"
  type        = bool
  default     = false
}

######
# aws_athena_named_query
######

variable "queries" {
  description = "A complete list of pre-configured queries"
  type = list(object({
    name        = string
    description = string
    query       = string
  }))
  default = []
}

######
# aws_glue_catalog_database
######

variable "catalog_name" {
  description = "The name of the glue data catalog"
  type        = string
}

variable "catalog_description" {
  description = "The description for the warehouse"
  type        = string
  default     = null
}

variable "crawler_name" {
  description = "The crawler's name"
  type        = string
}

######
# aws_glue_crawler
######

variable "excluded_files" {
  description = "A list of glob patterns used to exclude from the crawl"
  type        = list(string)
  default     = []
}

variable "schedule" {
  description = "A cron expression used to specify the schedule"
  type        = string
  default     = ""
}

variable "s3_bucket_name" {
  description = "The path to the Amazon S3 bucket"
  type        = string
}

variable "table_prefix" {
  description = "The table prefix used for catalog tables that are created"
  type        = string
  default     = null
}



######
# Tags
######

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
}
