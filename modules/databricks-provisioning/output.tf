output "databricks_host" {
  value = databricks_mws_workspaces.this.workspace_url
}

output "token_value" {
  value = databricks_token.pat.token_value
}