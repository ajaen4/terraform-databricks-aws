data "databricks_spark_version" "latest_lts" {
  long_term_support = true
}

data "databricks_node_type" "smallest" {
  local_disk = true
}

resource "databricks_cluster" "high_concurrency_cluster" {
  cluster_name            = "High-Concurrency-Terraform"
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 20

  spark_conf = {
    "spark.databricks.repl.allowedLanguages": "python,sql",
    "spark.databricks.cluster.profile": "serverless",
    "spark.databricks.passthrough.enabled": true,
    "spark.databricks.pyspark.enableProcessIsolation": true
  }

  autoscale {
    min_workers = 1
    max_workers = 2
  }

  aws_attributes {
    availability            = "SPOT"
    zone_id                 = "eu-west-1"
    first_on_demand         = 1
    spot_bid_price_percent  = 100
    instance_profile_arn = var.meta_role_arn
  }

  custom_tags = {
    "ResourceClass" = "Serverless"
  }
}