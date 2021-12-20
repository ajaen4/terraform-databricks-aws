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

resource "local_file" "add_read_role" {
    content     = templatefile("${path.root}/api-calls/add-role.tpl", 
                                {
                                iam_role = var.read_role_arn 
                                }
                              )
    filename = "${path.root}/api-calls/add-read-role.json"
}


resource "local_file" "add_write_role" {
    content     = templatefile("${path.root}/api-calls/add-role.tpl", 
                                {
                                iam_role = var.write_role_arn 
                                }
                              )
    filename = "${path.root}/api-calls/add-write-role.json"
}

resource "null_resource" "run_add_read_role" {

  provisioner "local-exec" {
    command = "${templatefile("${path.root}/api-calls/link-role.tpl", {
                                token = var.token,
                                group_id = databricks_group.read_only.id,
                                databricks_host = var.databricks_host,
                                json_file_name = local_file.add_read_role.filename
                                }
                              )}"
  }

  depends_on = [local_file.add_read_role]
}

resource "null_resource" "run_add_write_role" {

  provisioner "local-exec" {
    command = "${templatefile("${path.root}/api-calls/link-role.tpl", {
                                token = var.token,
                                group_id = databricks_group.all_access.id,
                                databricks_host = var.databricks_host,
                                json_file_name = local_file.add_write_role.filename
                                }
                              )}"
  }

  depends_on = [local_file.add_write_role]
}