curl -H "Authorization: Bearer ${token}" -X PATCH \
${databricks_host}/api/2.0/preview/scim/v2/Groups/${group_id} \
--header 'Content-type: application/scim+json' \
--data @${json_file_name} \
| jq .