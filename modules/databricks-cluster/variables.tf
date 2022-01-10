variable "aws_region" {
  type = string
}

variable "meta_instance_profile_arn" {
  type = string
}

variable "cluster_config" {
  type = any
}

variable "tags" {
  type = map(string)
}

variable "log_bucket_id" {
  type = string
}

variable "datalake_key_arn" {
  type = string
}

variable "logging_key_arn" {
  type = string
}

variable "datalake_client_side_enc" {
  type = string
}

variable "spark_conf" {

  default = {
    "spark.databricks.repl.allowedLanguages" : "python,sql",
    "spark.databricks.cluster.profile" : "serverless",
    "spark.databricks.passthrough.enabled" : true,
    "spark.databricks.pyspark.enableProcessIsolation" : true,
    "spark.databricks.hive.metastore.glueCatalog.enabled" : true
    #caches for glue to run faster
    "spark.hadoop.aws.glue.cache.db.enable" : true,
    "spark.hadoop.aws.glue.cache.db.size" : 1000,
    "spark.hadoop.aws.glue.cache.db.ttl-mins" : 30,
    "spark.hadoop.aws.glue.cache.table.enable" : true,
    "spark.hadoop.aws.glue.cache.table.size" : 1000,
    "spark.hadoop.aws.glue.cache.table.ttl-mins" : 30
  }

  type = map(any)
}