# AWS Security Group Terraform Module

Terraform module which creates a Security Group on AWS.

* [AWS EC2 Security Group](https://www.terraform.io/docs/providers/aws/r/security_group.html)
* [AWS EC2 Security Group Rule](https://www.terraform.io/docs/providers/aws/r/security_group_rule.html)

## Terraform versions

Only Terraform 0.14 is supported.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_sg"></a> [create\_sg](#input\_create\_sg) | Controls if the security group should be created | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The security group description | `string` | `""` | no |
| <a name="input_egress_cidr_blocks"></a> [egress\_cidr\_blocks](#input\_egress\_cidr\_blocks) | List of IPv4 CIDR blocks | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_egress_ipv6_cidr_blocks"></a> [egress\_ipv6\_cidr\_blocks](#input\_egress\_ipv6\_cidr\_blocks) | List of IPv6 CIDR blocks | `list(string)` | <pre>[<br>  "::/0"<br>]</pre> | no |
| <a name="input_egress_prefix_list_ids"></a> [egress\_prefix\_list\_ids](#input\_egress\_prefix\_list\_ids) | List of prefix list IDs | `list(string)` | `[]` | no |
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | List of egress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | List of IPv4 CIDR blocks | `list(string)` | `[]` | no |
| <a name="input_ingress_ipv6_cidr_blocks"></a> [ingress\_ipv6\_cidr\_blocks](#input\_ingress\_ipv6\_cidr\_blocks) | List of IPv6 CIDR blocks | `list(string)` | `[]` | no |
| <a name="input_ingress_prefix_list_ids"></a> [ingress\_prefix\_list\_ids](#input\_ingress\_prefix\_list\_ids) | List of prefix list IDs | `list(string)` | `[]` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | List of ingress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the security group | `string` | `null` | no |
| <a name="input_revoke_rules_on_delete"></a> [revoke\_rules\_on\_delete](#input\_revoke\_rules\_on\_delete) | Should be true to indicates that it will revoke all rules before deleting itself | `bool` | `false` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | Map of known security group rules ('name' = ['from port', 'to port', 'protocol', 'description']) | `map(list(any))` | <pre>{<br>  "_": [<br>    "",<br>    "",<br>    "",<br>    ""<br>  ],<br>  "all-all": [<br>    -1,<br>    -1,<br>    "-1",<br>    "All protocols"<br>  ],<br>  "http-80-tcp": [<br>    80,<br>    80,<br>    "tcp",<br>    "HTTP"<br>  ],<br>  "http-8080-tcp": [<br>    8080,<br>    8080,<br>    "tcp",<br>    "HTTP"<br>  ],<br>  "https-443-tcp": [<br>    443,<br>    443,<br>    "tcp",<br>    "HTTPS"<br>  ],<br>  "nfs-tcp": [<br>    2049,<br>    2049,<br>    "tcp",<br>    "NFS/EFS"<br>  ],<br>  "ssh-tcp": [<br>    22,<br>    22,<br>    "tcp",<br>    "SSH"<br>  ]<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where the security group is assigned | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_description"></a> [security\_group\_description](#output\_security\_group\_description) | The description of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | The name of the security group |
| <a name="output_security_group_owner_id"></a> [security\_group\_owner\_id](#output\_security\_group\_owner\_id) | The owner ID |
| <a name="output_security_group_vpc_id"></a> [security\_group\_vpc\_id](#output\_security\_group\_vpc\_id) | The VPC ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Test

### Environment

Since most automated tests written with Terratest can make potentially destructive changes in your environment, we
strongly recommend running tests in an environment that is totally separate from production. For example, if you are
testing infrastructure code for AWS, you should run your tests in a completely separate AWS account.

### Requirements

Terratest uses the Go testing framework. To use terratest, you need to install:

* [Go](https://golang.org/) (requires version >=1.13)

### Running

Now you should be able to run the example test.

1. Change your working directory to the `test/src` folder.
1. Each time you want to run the tests:

```bash
go test -timeout 20m
```

## Terraform CLI

On the `examples/dummy` folder, perform the following commands.

* Get the plugins:

```bash
terraform init
```

* Review and apply the infrastructure test build:

```bash
terraform apply -var-file=fixtures.eu-west-1.tfvars
```

* Remove all resources:

```bash
terraform destroy -auto-approve
```
