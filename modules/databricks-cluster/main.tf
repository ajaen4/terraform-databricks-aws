data "databricks_spark_version" "latest_lts" {
  long_term_support = true
}

data "databricks_node_type" "smallest" {
  local_disk    = var.cluster_config.node_config.local_disk
  min_memory_gb = var.cluster_config.node_config.min_gb
  min_cores     = var.cluster_config.node_config.min_cores
}

resource "databricks_cluster" "high_concurrency_cluster" {
  cluster_name            = var.cluster_config.cluster_name
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = var.cluster_config.autotermination_minutes

  autoscale {
    min_workers = var.cluster_config.autoscale.min_workers
    max_workers = var.cluster_config.autoscale.max_workers
  }

  aws_attributes {
    availability           = var.cluster_config.aws_attributes.availability
    first_on_demand        = var.cluster_config.aws_attributes.first_on_demand
    spot_bid_price_percent = var.cluster_config.aws_attributes.spot_bid_price_percent
    ebs_volume_count       = var.cluster_config.aws_attributes.ebs_volume_count
    ebs_volume_size        = var.cluster_config.aws_attributes.ebs_volume_size
    instance_profile_arn   = var.meta_instance_profile_arn
  }

  spark_conf = var.datalake_client_side_enc ? merge({
    #encryption
    "spark.hadoop.fs.s3a.server-side-encryption.key" : var.datalake_key_arn
    "spark.hadoop.fs.s3a.server-side-encryption-algorithm" : "SSE-KMS"
  }, var.spark_conf) : var.spark_conf

  cluster_log_conf {
    s3 {
      destination       = "s3://${var.log_bucket_id}/cluster-logs"
      region            = var.aws_region
      endpoint          = "https://s3-${var.aws_region}.amazonaws.com"
      enable_encryption = true
      encryption_type   = "sse-kms"
      kms_key           = var.logging_key_arn
    }
  }

  custom_tags = var.tags
}