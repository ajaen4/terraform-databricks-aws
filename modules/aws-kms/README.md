# AWS KMS Terraform Module

Terraform module which creates a KMS on AWS.

* [AWS KMS](https://www.terraform.io/docs/providers/aws/r/kms_key.html)

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
| [aws_kms_alias.external](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_alias.internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_external_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_external_key) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_key"></a> [create\_key](#input\_create\_key) | Controls if key should be created | `bool` | `true` | no |
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | Duration in days after which the key is deleted after destruction of the resource | `number` | `30` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the key as viewed in AWS console | `string` | `""` | no |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | Should be true to indicates that the key rotation is enabled | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Should be false to indicates that the key is disabled | `bool` | `true` | no |
| <a name="input_external_kms_key"></a> [external\_kms\_key](#input\_external\_kms\_key) | Controls if external key should be created | `bool` | `false` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Should be false to indicates that the key is disabled | `bool` | `true` | no |
| <a name="input_key_material_base64"></a> [key\_material\_base64](#input\_key\_material\_base64) | Base64 encoded 256-bit symmetric encryption key material to import | `string` | `null` | no |
| <a name="input_key_usage"></a> [key\_usage](#input\_key\_usage) | The intended use of the key | `string` | `"ENCRYPT_DECRYPT"` | no |
| <a name="input_name"></a> [name](#input\_name) | The display name of the alias | `string` | `null` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | A valid KMS policy JSON document | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | n/a | yes |
| <a name="input_valid_to"></a> [valid\_to](#input\_valid\_to) | Time at which the imported key material expires | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_alias_arn"></a> [kms\_alias\_arn](#output\_kms\_alias\_arn) | The Amazon Resource Name (ARN) of the key alias |
| <a name="output_kms_alias_name"></a> [kms\_alias\_name](#output\_kms\_alias\_name) | The display name of the key alias |
| <a name="output_kms_arn"></a> [kms\_arn](#output\_kms\_arn) | The Amazon Resource Name (ARN) of the key |
| <a name="output_kms_external_alias_arn"></a> [kms\_external\_alias\_arn](#output\_kms\_external\_alias\_arn) | The Amazon Resource Name (ARN) of the external key alias |
| <a name="output_kms_external_alias_name"></a> [kms\_external\_alias\_name](#output\_kms\_external\_alias\_name) | The display name of the external key alias |
| <a name="output_kms_external_arn"></a> [kms\_external\_arn](#output\_kms\_external\_arn) | The Amazon Resource Name (ARN) of the external key |
| <a name="output_kms_external_key_id"></a> [kms\_external\_key\_id](#output\_kms\_external\_key\_id) | The globally unique identifier for the external key |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | The globally unique identifier for the key |
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
