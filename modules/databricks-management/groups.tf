resource "databricks_group" "read_only" {
  display_name = "Read only"
  allow_cluster_create = false
  allow_instance_pool_create = false
}

resource "databricks_group" "all_access" {
  display_name = "All access"
  allow_cluster_create = false
  allow_instance_pool_create = false
}