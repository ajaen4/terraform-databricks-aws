resource "databricks_service_principal" "this" {
  provider             = databricks.created_workspace
  display_name         = "Service Principal"
  allow_cluster_create = true
}

data "databricks_group" "admins" {
  provider     = databricks.created_workspace
  display_name = "admins"
  depends_on   = [databricks_mws_workspaces.this]
}

resource "databricks_group_member" "this" {
  provider  = databricks.created_workspace
  group_id  = data.databricks_group.admins.id
  member_id = databricks_service_principal.this.id
}

resource "databricks_permissions" "token_usage" {
  provider      = databricks.created_workspace
  authorization = "tokens"
  access_control {
    service_principal_name = databricks_service_principal.this.application_id
    permission_level       = "CAN_USE"
  }
}