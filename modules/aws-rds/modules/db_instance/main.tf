locals {
  is_mssql = element(split("-", var.engine_name), 0) == "sqlserver"

  resource_name = format(
    "${local.resource_prefix}-%s-rds01-%s",
    var.identifier,
    var.tags.environment,
  )
}

resource "aws_iam_role" "enhanced_monitoring" {
  count = var.create_monitoring_role ? 1 : 0

  name               = var.monitoring_role_name
  assume_role_policy = file("${path.module}/policies/enhanced-monitoring.json")

  tags = merge(
    var.tags,
    {
      "resource_name" = local.resource_name,
      "resource_type" = "iam_role",
    }
  )
}

resource "aws_iam_role_policy_attachment" "enhanced_monitoring" {
  count = var.create_monitoring_role ? 1 : 0

  role       = aws_iam_role.enhanced_monitoring[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_db_instance" "this" {
  count = var.create_db ? 1 : 0

  identifier        = local.resource_name
  engine            = var.engine_name
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_encrypted = var.storage_encrypted
  storage_type      = var.storage_type
  iops              = var.iops
  kms_key_id        = var.kms_key_id
  license_model     = var.license_model

  name                                = var.name
  username                            = var.username
  password                            = var.password
  port                                = var.port
  iam_database_authentication_enabled = var.iam_database_authentication_enabled

  replicate_source_db = var.replicate_source_db

  snapshot_identifier       = var.snapshot_identifier
  copy_tags_to_snapshot     = var.copy_tags_to_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier
  skip_final_snapshot       = var.skip_final_snapshot

  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name   = var.db_subnet_group_name
  parameter_group_name   = var.parameter_group_name
  option_group_name      = var.option_group_name

  availability_zone   = var.availability_zone
  multi_az            = var.multi_az
  publicly_accessible = var.publicly_accessible
  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = coalesce(var.monitoring_role_arn, aws_iam_role.enhanced_monitoring.*.arn, null)

  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  apply_immediately           = var.apply_immediately
  maintenance_window          = var.maintenance_window
  max_allocated_storage       = var.max_allocated_storage

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_enabled == true ? var.performance_insights_retention_period : null
  performance_insights_kms_key_id       = var.performance_insights_enabled == true ? var.performance_insights_kms_key_id : null

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window

  domain               = var.domain
  domain_iam_role_name = var.domain_iam_role_name

  character_set_name = var.character_set_name
  timezone           = local.is_mssql ? var.timezone : null

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  deletion_protection = var.deletion_protection

  tags = merge(
    var.tags,
    {
      "resource_name" = local.resource_name,
      "resource_type" = "rds",
    }
  )

  timeouts {
    create = lookup(var.timeouts, "create", null)
    delete = lookup(var.timeouts, "delete", null)
    update = lookup(var.timeouts, "update", null)
  }
}
