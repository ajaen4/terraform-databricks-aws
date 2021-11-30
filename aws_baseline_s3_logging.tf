module "aws_baseline_s3_logging" {
  source = "./modules/aws-s3-bucket"

  bucket_name             = "${var.prefix}-s3-logging"
  block_public_acls       = var.aws_baseline_s3_logging.block_public_acls
  block_public_policy     = var.aws_baseline_s3_logging.block_public_policy
  create_s3_bucket        = var.aws_baseline_s3_logging.create_s3_bucket
  force_destroy           = var.aws_baseline_s3_logging.force_destroy
  kms_master_key_arn      = module.aws_baseline_kms.kms_arn
  restrict_public_buckets = var.aws_baseline_s3_logging.restrict_public_buckets
  sse_algorithm           = var.aws_baseline_s3_logging.sse_algorithm
  sse_prevent             = var.aws_baseline_s3_logging.sse_prevent
  versioning              = var.aws_baseline_s3_logging.versioning
  tags                    = var.tags

  depends_on = [module.aws_baseline_kms]
}

module "aws_databricks_logging" {
  source = "./modules/aws-s3-bucket"

  bucket_name         = "${var.prefix}-databricks-logging"
  block_public_acls   = var.aws_databricks_logs_s3.block_public_acls
  block_public_policy = var.aws_databricks_logs_s3.block_public_policy
  create_s3_bucket    = var.aws_databricks_logs_s3.create_s3_bucket
  force_destroy       = var.aws_databricks_logs_s3.force_destroy
  kms_master_key_arn      = module.aws_baseline_kms.kms_arn
  restrict_public_buckets = var.aws_databricks_logs_s3.restrict_public_buckets
  ignore_public_acls      = var.aws_databricks_logs_s3.ignore_public_acls
  sse_algorithm           = var.aws_databricks_logs_s3.sse_algorithm
  sse_prevent             = var.aws_databricks_logs_s3.sse_prevent
  versioning = var.aws_databricks_logs_s3.versioning
  tags       = var.tags

  depends_on = [module.aws_baseline_kms]
}