data "databricks_current_user" "me" {
}
data "databricks_spark_version" "latest" {
}
data "databricks_node_type" "smallest" {
  local_disk = true
}

