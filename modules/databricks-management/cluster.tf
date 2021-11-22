data "databricks_spark_version" "latest_lts" {
  long_term_support = true
}

data "databricks_node_type" "smallest" {
  local_disk    = true
  min_memory_gb = 31
  min_cores     = 4
}

resource "databricks_cluster" "high_concurrency_cluster" {
  cluster_name            = "High-Concurrency-Terraform"
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 30

  spark_conf = {
    "spark.databricks.repl.allowedLanguages" : "python,sql",
    "spark.databricks.cluster.profile" : "serverless",
    "spark.databricks.passthrough.enabled" : true,
    "spark.databricks.pyspark.enableProcessIsolation" : true,
    "spark.databricks.hive.metastore.glueCatalog.enabled" : true,
    "spark.hadoop.aws.region" : "eu-west-1",
    #caches for glue to run faster
    "spark.hadoop.aws.glue.cache.db.enable" : true,
    "spark.hadoop.aws.glue.cache.db.size" : 1000,
    "spark.hadoop.aws.glue.cache.db.ttl-mins" : 30,
    "spark.hadoop.aws.glue.cache.table.enable" : true,
    "spark.hadoop.aws.glue.cache.table.size" : 1000,
    "spark.hadoop.aws.glue.cache.table.ttl-mins" : 30
  }

  autoscale {
    min_workers = 1
    max_workers = 2
  }

  aws_attributes {
    availability           = "SPOT_WITH_FALLBACK"
    first_on_demand        = 1
    spot_bid_price_percent = 60
    ebs_volume_count       = 1
    ebs_volume_size        = 100
    instance_profile_arn   = var.meta_instance_profile_arn
  }

  custom_tags = {
    "ResourceClass" = "Serverless"
  }
}

resource "databricks_dbfs_file" "core_site_config" {
  content_base64 = base64encode(
    templatefile("${path.root}/config-files/core-site.tpl", { kms_key_arn = var.kms_key_arn_s3_enc })
  )
  path = "/tmp/core-site.xml"
}

resource "databricks_global_init_script" "encryption_init_script" {
  source  = "${path.root}/config-files/init.sh"
  name    = "encryption_init_script"
  enabled = true
}