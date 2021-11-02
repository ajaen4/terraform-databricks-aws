# AWS Athena Terraform Module

Terraform module which creates a athena engine on AWS.

* [AWS Glue Crawler](https://www.terraform.io/docs/providers/aws/r/glue_crawler.html)
* [AWS Athena Query](https://www.terraform.io/docs/providers/aws/r/athena_named_query.html)

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
| [aws_athena_named_query.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/athena_named_query) | resource |
| [aws_athena_workgroup.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/athena_workgroup) | resource |
| [aws_glue_catalog_database.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_database) | resource |
| [aws_glue_crawler.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_crawler) | resource |
| [aws_iam_policy.dst](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.src](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.athena](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.glue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.athena](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.dst](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.glue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.src](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role_athena](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_glue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.dst](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.src](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_catalog_description"></a> [catalog\_description](#input\_catalog\_description) | The description for the warehouse | `string` | `null` | no |
| <a name="input_catalog_name"></a> [catalog\_name](#input\_catalog\_name) | The name of the glue data catalog | `string` | n/a | yes |
| <a name="input_cloudwatch_metrics"></a> [cloudwatch\_metrics](#input\_cloudwatch\_metrics) | Should be true to enable CloudWatch metrics for workgroup | `bool` | `false` | no |
| <a name="input_create_athena"></a> [create\_athena](#input\_create\_athena) | Controls if athena engine should be created | `bool` | `true` | no |
| <a name="input_enforce_config"></a> [enforce\_config](#input\_enforce\_config) | Should be true to override client-side settings | `bool` | `false` | no |
| <a name="input_excluded_files"></a> [excluded\_files](#input\_excluded\_files) | A list of glob patterns used to exclude from the crawl | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The workgroup's name | `string` | n/a | yes |
| <a name="input_queries"></a> [queries](#input\_queries) | A complete list of pre-configured queries | <pre>list(object({<br>    name        = string<br>    description = string<br>    query       = string<br>  }))</pre> | `[]` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | The path to the Amazon S3 bucket | `string` | n/a | yes |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | A cron expression used to specify the schedule | `string` | `""` | no |
| <a name="input_table_prefix"></a> [table\_prefix](#input\_table\_prefix) | The table prefix used for catalog tables that are created | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | n/a | yes |
| <a name="input_workgroup_description"></a> [workgroup\_description](#input\_workgroup\_description) | The description of this workgroup | `string` | `null` | no |
| <a name="input_workgroup_state"></a> [workgroup\_state](#input\_workgroup\_state) | The state of the workgroup | `string` | `"ENABLED"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_athena_crawler_arn"></a> [athena\_crawler\_arn](#output\_athena\_crawler\_arn) | The ARN of glue crawler |
| <a name="output_athena_crawler_id"></a> [athena\_crawler\_id](#output\_athena\_crawler\_id) | The glue crawler identifier |
| <a name="output_athena_wg_arn"></a> [athena\_wg\_arn](#output\_athena\_wg\_arn) | The ARN of workgroup |
| <a name="output_athena_wg_id"></a> [athena\_wg\_id](#output\_athena\_wg\_id) | The workgroup name |
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

### Terraform CLI

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
