output "databricks_host" {
  value = databricks_mws_workspaces.this.workspace_url
}

output "create_cluster_token" {
  value     = databricks_token.pat.token_value
  sensitive = true
}

output "service_ppal_token" {
  value     = databricks_obo_token.this.token_value
  sensitive = true
}