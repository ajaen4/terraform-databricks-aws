module "aws_root_s3" {
  source = "./modules/aws-s3-bucket"

  bucket_name             = "${var.prefix}-rootbucket"
  is_root_bucket          = true
  block_public_acls       = var.aws_root_s3.block_public_acls
  block_public_policy     = var.aws_root_s3.block_public_policy
  create_s3_bucket        = var.aws_root_s3.create_s3_bucket
  force_destroy           = var.aws_root_s3.force_destroy
  kms_master_key_arn      = module.aws_datalake_kms.kms_arn
  restrict_public_buckets = var.aws_root_s3.restrict_public_buckets
  sse_algorithm           = var.aws_root_s3.sse_algorithm
  sse_prevent             = var.dbfs_client_side_enc
  versioning              = var.aws_root_s3.versioning
  tags                    = var.tags

  depends_on = [module.aws_datalake_kms]
}

module "aws_datalake_s3_raw" {
  source = "./modules/aws-s3-bucket"

  bucket_name             = "${var.prefix}-raw"
  block_public_acls       = var.aws_datalake_s3_raw.block_public_acls
  block_public_policy     = var.aws_datalake_s3_raw.block_public_policy
  create_s3_bucket        = var.aws_datalake_s3_raw.create_s3_bucket
  force_destroy           = var.aws_datalake_s3_raw.force_destroy
  kms_master_key_arn      = module.aws_datalake_kms.kms_arn
  restrict_public_buckets = var.aws_datalake_s3_raw.restrict_public_buckets
  sse_algorithm           = var.aws_datalake_s3_raw.sse_algorithm
  sse_prevent             = var.datalake_client_side_enc
  versioning              = var.aws_datalake_s3_raw.versioning
  tags                    = var.tags

  depends_on = [module.aws_datalake_kms]
}

module "aws_datalake_s3_prepared" {
  source = "./modules/aws-s3-bucket"

  bucket_name             = "${var.prefix}-prepared"
  block_public_acls       = var.aws_datalake_s3_prepared.block_public_acls
  block_public_policy     = var.aws_datalake_s3_prepared.block_public_policy
  create_s3_bucket        = var.aws_datalake_s3_prepared.create_s3_bucket
  force_destroy           = var.aws_datalake_s3_prepared.force_destroy
  kms_master_key_arn      = module.aws_datalake_kms.kms_arn
  restrict_public_buckets = var.aws_datalake_s3_prepared.restrict_public_buckets
  sse_algorithm           = var.aws_datalake_s3_prepared.sse_algorithm
  sse_prevent             = var.datalake_client_side_enc
  versioning              = var.aws_datalake_s3_prepared.versioning
  tags                    = var.tags

  depends_on = [module.aws_datalake_kms]
}

module "aws_datalake_s3_trusted" {
  source = "./modules/aws-s3-bucket"

  bucket_name             = "${var.prefix}-trusted"
  block_public_acls       = var.aws_datalake_s3_trusted.block_public_acls
  block_public_policy     = var.aws_datalake_s3_trusted.block_public_policy
  create_s3_bucket        = var.aws_datalake_s3_trusted.create_s3_bucket
  force_destroy           = var.aws_datalake_s3_trusted.force_destroy
  kms_master_key_arn      = module.aws_datalake_kms.kms_arn
  restrict_public_buckets = var.aws_datalake_s3_trusted.restrict_public_buckets
  sse_algorithm           = var.aws_datalake_s3_trusted.sse_algorithm
  sse_prevent             = var.datalake_client_side_enc
  versioning              = var.aws_datalake_s3_trusted.versioning
  tags                    = var.tags

  depends_on = [module.aws_datalake_kms]
}

