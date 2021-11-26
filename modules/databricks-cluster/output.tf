output "databricks_spark_version" {
  value = data.databricks_spark_version.latest_lts
}

output "databricks_node_type" {
  value = data.databricks_node_type.smallest
}