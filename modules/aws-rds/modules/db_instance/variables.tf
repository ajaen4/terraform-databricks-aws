
######
# aws_db_instance
######

variable "create_db" {
  description = "Controls if RDS instance should be created"
  type        = bool
  default     = true
}

variable "create_monitoring_role" {
  description = "Controls if IAM role should be created to send enhanced monitoring metrics to CloudWatch Logs"
  type        = bool
  default     = false
}

variable "identifier" {
  description = "The name of the DB instance"
  type        = string
  default     = null
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
  default     = null
}

variable "allow_major_version_upgrade" {
  description = "Should be true to indicate that major version upgrades are allowed"
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "Should be true to indicate that any database modifications are applied immediately"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Should be true to indicate that that minor engine upgrades will be applied automatically"
  type        = bool
  default     = true
}

variable "availability_zone" {
  description = "The Availability Zone for the DB instance"
  type        = string
  default     = ""
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 0
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created"
  type        = string
  default     = null
}

variable "character_set_name" {
  description = "The character set name to use for DB encoding in Oracle instances"
  type        = string
  default     = null
}

variable "copy_tags_to_snapshot" {
  description = "Should be true to copy all instance tags to snapshots"
  type        = bool
  default     = false
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group"
  type        = string
  default     = ""
}

variable "deletion_protection" {
  description = "Should be true to indicate that the database cannot be deleted"
  type        = bool
  default     = false
}

variable "domain" {
  description = "The ID of the Directory Service Active Directory domain to create the DB instance in"
  type        = string
  default     = null
}

variable "domain_iam_role_name" {
  description = "The name of the IAM role to be used when making API calls to the Directory Service"
  type        = string
  default     = null
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs"
  type        = list(string)
  default     = []
}

variable "engine_name" {
  description = "The database engine to use"
  type        = string
  default     = null
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = null
}

variable "final_snapshot_identifier" {
  description = "The name of your final snapshot when the DB instance is deleted"
  type        = string
  default     = null
}

variable "iam_database_authentication_enabled" {
  description = "Should be true to indicate that IAM accounts are enabled"
  type        = bool
  default     = false
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = null
}

variable "iops" {
  description = "The amount of provisioned IOPS"
  type        = number
  default     = 0
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key"
  type        = string
  default     = ""
}

variable "license_model" {
  description = "License model information for this DB instance"
  type        = string
  default     = ""
}

variable "maintenance_window" {
  description = "The window to perform maintenance in"
  type        = string
  default     = null
}

variable "max_allocated_storage" {
  description = "The upper limit to which Amazon RDS can automatically scale the storage of the DB instance"
  type        = number
  default     = 0
}

variable "monitoring_interval" {
  description = "The interval between points when Enhanced Monitoring metrics are collected for the DB instance"
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  type        = string
  default     = ""
}

variable "monitoring_role_name" {
  description = "Name of the IAM role which will be created when create_monitoring_role is enabled"
  type        = string
  default     = "rds-monitoring-role"
}

variable "multi_az" {
  description = "Should be true to indicate that the DB instance is multi-AZ"
  type        = bool
  default     = false
}

variable "name" {
  description = "The name of the database to create when the DB instance is createdd"
  type        = string
  default     = null
}

variable "option_group_name" {
  description = "Name of the DB option group to associate."
  type        = string
  default     = ""
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  type        = string
  default     = ""
}

variable "password" {
  description = "Password for the master DB user"
  type        = string
  default     = null
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = null
}

variable "publicly_accessible" {
  description = "Should be true to indicate that DB instance is publicly accessible"
  type        = bool
  default     = false
}

variable "replicate_source_db" {
  description = "Specifies that this resource is a Replicate database"
  type        = string
  default     = null
}

variable "skip_final_snapshot" {
  description = "Should be true to determinate whether a final DB snapshot is created before the DB instance is deleted."
  type        = bool
  default     = false
}

variable "snapshot_identifier" {
  description = "Specifies whether or not to create this database from a snapshot"
  type        = string
  default     = null
}

variable "storage_encrypted" {
  description = "Should be true to indicate that the DB instance is encrypted"
  type        = bool
  default     = false
}

variable "storage_type" {
  description = "Specifies the storage type for the DB instance"
  type        = string
  default     = "gp2"
}

variable "timezone" {
  description = "Time zone of the DB instance"
  type        = string
  default     = null
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

variable "performance_insights_enabled" {
  description = "Should be true to indicate that Performance Insights are enabled"
  type        = bool
  default     = false
}

variable "performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to encrypt Performance Insights data"
  type        = string
  default     = ""
}

variable "performance_insights_retention_period" {
  description = "The amount of time in days to retain Performance Insights data"
  type        = number
  default     = 7
}

variable "timeouts" {
  description = "Updated Terraform resource management timeouts"
  type        = map(string)
  default = {
    create = "40m"
    update = "80m"
    delete = "40m"
  }
}

######
# Tags
######

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}
