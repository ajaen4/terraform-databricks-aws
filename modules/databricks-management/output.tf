output "current_user" {
  value = data.databricks_current_user.me
}

output "databricks_spark_version" {
  value = data.databricks_spark_version.latest
}

output "databricks_node_type" {
  value = data.databricks_node_type.smallest
}