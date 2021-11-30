resource "databricks_group" "read_only" {
  provider                   = databricks.service_ppal
  display_name               = "Read only"
  allow_cluster_create       = false
  allow_instance_pool_create = false
}

resource "databricks_group" "all_access" {
  provider                   = databricks.service_ppal
  display_name               = "All access"
  allow_cluster_create       = false
  allow_instance_pool_create = false
}

data "databricks_group" "admins" {
  provider     = databricks.service_ppal
  display_name = "admins"
}