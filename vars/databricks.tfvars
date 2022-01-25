aws_baseline_account = {
  region     = "eu-west-1"
}

databricks_acc_username_param_path = "/databricks/admin_account_param"
databricks_pss_param_path          = "/databricks/admin_pss"

tags = {
  terraform   = "true"
  project     = "cm-vpc"
  region      = "eu-west-1"
  company     = "bluetab"
  environment = "test"
}

dbfs_client_side_enc     = true
datalake_client_side_enc = true

prefix         = "cm-vpc"
workspace_name = "customer-managed-vpc"

customer_managed_vpc = {
  vpc_name = "customer-managed-vpc"

  cidr            = "10.0.0.0/16"
  private_azs     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  public_azs      = ["eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  create_vpc                       = true
  default_vpc_enable_dns_hostnames = true
  default_vpc_enable_dns_support   = true

  enable_flow_log           = true
  flow_log_destination_type = "s3"

  enable_dns_hostnames = true
  enable_dns_support   = true

  manage_default_security_group = true
  default_security_group_name   = "def-sg"
}

aws_baseline_kms = {
  create_key              = true
  deletion_window_in_days = 7
  description             = "KMS key to encrypt objects inside s3 bucket logging"
  enable_key_rotation     = true
  enabled                 = true
  is_enabled              = true
  key_usage               = "ENCRYPT_DECRYPT"
  name                    = "s3-logging"
}

aws_datalake_kms = {
  create_key              = true
  deletion_window_in_days = 7
  description             = "KMS key to encrypt objects inside s3 bucket (root, raw, prepared & trusted)"
  enable_key_rotation     = true
  enabled                 = true
  is_enabled              = true
  key_usage               = "ENCRYPT_DECRYPT"
  name                    = "s3-zones"
}

aws_baseline_s3_logging = {
  block_public_acls       = true
  block_public_policy     = true
  create_s3_bucket        = true
  force_destroy           = true
  restrict_public_buckets = true
  sse_algorithm           = "aws:kms"
  sse_prevent             = false
  versioning              = true
  lifecycle_rule = [{
    id      = "aws-baseline-s3-logging-transition"
    enabled = true

    transition = [
      {
        days          = 30
        storage_class = "GLACIER"
      }
    ]

    expiration = [
      {
        days = 180
      }
    ]
  }]
}

aws_databricks_logs_s3 = {
  block_public_acls       = true
  block_public_policy     = true
  create_s3_bucket        = true
  force_destroy           = true
  restrict_public_buckets = true
  ignore_public_acls      = true
  sse_algorithm           = "aws:kms"
  sse_prevent             = false
  versioning              = false
  lifecycle_rule = [{
    id      = "aws-databricks-s3-logging-transition"
    enabled = true

    transition = [
      {
        days          = 30
        storage_class = "GLACIER"
      }
    ]

    expiration = [
      {
        days = 180
      }
    ]
  }]
}

aws_root_s3 = {
  block_public_acls       = true
  block_public_policy     = true
  create_s3_bucket        = true
  force_destroy           = true
  restrict_public_buckets = true
  sse_algorithm           = "aws:kms"
  versioning              = false
}

aws_datalake_s3_raw = {
  block_public_acls       = true
  block_public_policy     = true
  create_s3_bucket        = true
  force_destroy           = true
  restrict_public_buckets = true
  sse_algorithm           = "aws:kms"
  versioning              = false
}

aws_datalake_s3_prepared = {
  block_public_acls       = true
  block_public_policy     = true
  create_s3_bucket        = true
  force_destroy           = true
  restrict_public_buckets = true
  sse_algorithm           = "aws:kms"
  versioning              = true
}

aws_datalake_s3_trusted = {
  block_public_acls       = true
  block_public_policy     = true
  create_s3_bucket        = true
  force_destroy           = true
  restrict_public_buckets = true
  sse_algorithm           = "aws:kms"
  versioning              = true
}

cluster_config = {
  cluster_name            = "High-Concurrency-Terraform"
  autotermination_minutes = 30

  node_config = {
    local_disk = false
    min_gb     = 15
    min_cores  = 2
  }

  autoscale = {
    min_workers = 1
    max_workers = 2
  }

  aws_attributes = {
    availability           = "SPOT_WITH_FALLBACK"
    first_on_demand        = 1
    spot_bid_price_percent = 60
    ebs_volume_count       = 1
    ebs_volume_size        = 32
  }
}
