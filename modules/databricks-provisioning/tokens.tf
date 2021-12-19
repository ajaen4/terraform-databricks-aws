// Even though we don't use this token, it's necessary to create it before the service ppal's
// token. If not, it will result in a tokens tokens doesn't exist error
resource "databricks_token" "pat" {
  provider         = databricks.created_workspace
  comment          = "Needed to start tokens and create cluster"
  lifetime_seconds = var.token_lifetime_seconds
}

resource "databricks_obo_token" "this" {
  provider         = databricks.created_workspace
  application_id   = databricks_service_principal.this.application_id
  comment          = "PAT on behalf of ${databricks_service_principal.this.display_name}"
  lifetime_seconds = var.token_lifetime_seconds

  depends_on = [
    databricks_group_member.this,
  databricks_token.pat]
}