module "aws_vpc_flow_log_s3" {
  source = "./modules/aws-s3-bucket"

  bucket_name             = "${var.prefix}-vpc-flow-log-bucket"
  block_public_acls       = var.aws_vpc_flow_log_s3.block_public_acls
  block_public_policy     = var.aws_vpc_flow_log_s3.block_public_policy
  create_s3_bucket        = var.aws_vpc_flow_log_s3.create_s3_bucket
  force_destroy           = var.aws_vpc_flow_log_s3.force_destroy
  kms_master_key_arn      = module.aws_datalake_kms.kms_arn
  restrict_public_buckets = var.aws_vpc_flow_log_s3.restrict_public_buckets
  sse_algorithm           = var.aws_vpc_flow_log_s3.sse_algorithm
  sse_prevent             = var.aws_vpc_flow_log_s3.sse_prevent
  versioning              = var.aws_vpc_flow_log_s3.versioning
  tags                    = var.tags

  depends_on = [module.aws_datalake_kms]
}