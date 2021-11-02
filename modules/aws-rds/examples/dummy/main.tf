
provider "aws" {
  region = "eu-west-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  name   = "default"
}

module "rds_instance" {
  source = "../../"

  identifier = var.identifier

  engine_name       = var.engine_name
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_encrypted = var.storage_encrypted

  name     = var.name
  username = var.username
  password = var.password
  port     = var.port

  vpc_security_group_ids = [data.aws_security_group.default.id]

  maintenance_window      = var.maintenance_window
  backup_window           = var.backup_window
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot
  deletion_protection     = var.deletion_protection

  tags = var.tags

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  # aws_db_subnet_group
  subnet_ids = data.aws_subnet_ids.all.ids

  # aws_db_parameter_group
  family = var.family
}
