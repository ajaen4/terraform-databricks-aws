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

  spark_conf = {
    "spark.databricks.repl.allowedLanguages" : "python,sql",
    "spark.databricks.cluster.profile" : "serverless",
    "spark.databricks.passthrough.enabled" : true,
    "spark.databricks.pyspark.enableProcessIsolation" : true,
    "spark.databricks.hive.metastore.glueCatalog.enabled" : true,
    "spark.hadoop.aws.region" : var.aws_region,
    #caches for glue to run faster
    "spark.hadoop.aws.glue.cache.db.enable" : true,
    "spark.hadoop.aws.glue.cache.db.size" : 1000,
    "spark.hadoop.aws.glue.cache.db.ttl-mins" : 30,
    "spark.hadoop.aws.glue.cache.table.enable" : true,
    "spark.hadoop.aws.glue.cache.table.size" : 1000,
    "spark.hadoop.aws.glue.cache.table.ttl-mins" : 30,
    #encryption
    "spark.hadoop.fs.s3a.server-side-encryption.key" : var.datalake_key_arn
    "spark.hadoop.fs.s3a.server-side-encryption-algorithm" : "SSE-KMS"
  }

  cluster_log_conf {
    s3 {
      destination = "s3://${var.log_bucket_id}/cluster-logs"
      region      = var.aws_region
      endpoint    = "https://s3-${var.aws_region}.amazonaws.com"
      enable_encryption = true
      encryption_type = "sse-kms"
      kms_key = var.logging_key_arn
    }
  }

  custom_tags = var.tags
}