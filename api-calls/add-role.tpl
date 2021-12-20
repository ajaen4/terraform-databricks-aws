{
  "schemas": [ "urn:ietf:params:scim:api:messages:2.0:PatchOp" ],
  "Operations": [
    {
      "op": "add",
      "path": "roles",
      "value": [
        {
          "value": "${iam_role}"
        }
      ]
    }
  ]
}
