output "databricks_host" {
  value = databricks_mws_workspaces.this.workspace_url
}

output "token_value" {
  value = databricks_obo_token.this.token_value
  sensitive = true
}