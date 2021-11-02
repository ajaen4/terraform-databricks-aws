# AWS Cloudwatch Terraform Module

Terraform module which creates cloudwatch metrics and configures cross-account on AWS.

* [AWS Cloudwatch Event Rule](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html)
* [AWS Cloudwatch Metric Alarm](https://www.terraform.io/docs/providers/aws/r/cloudwatch_metric_alarm.html)
* [AWS Cloudwatch Metric Filter](https://www.terraform.io/docs/providers/aws/r/cloudwatch_log_metric_filter.html)

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
| [aws_cloudwatch_event_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_log_metric_filter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_metric_filter) | resource |
| [aws_cloudwatch_metric_alarm.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.policy01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.policy02](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_arns"></a> [account\_arns](#input\_account\_arns) | The list of ARNs to allow monitoring accounts to view your data | `list(string)` | `[]` | no |
| <a name="input_actions_enabled"></a> [actions\_enabled](#input\_actions\_enabled) | Should be true to indicates whether or not actions should be executed during any changes to the alarm's state | `bool` | `false` | no |
| <a name="input_alarm_actions"></a> [alarm\_actions](#input\_alarm\_actions) | The list of actions (ARNs) to execute when this alarm transitions | `list(string)` | `[]` | no |
| <a name="input_alarm_description"></a> [alarm\_description](#input\_alarm\_description) | The description for the alarm | `string` | `""` | no |
| <a name="input_alarm_name"></a> [alarm\_name](#input\_alarm\_name) | The descriptive name for the alarm | `string` | `""` | no |
| <a name="input_comparison_operator"></a> [comparison\_operator](#input\_comparison\_operator) | The arithmetic operation to use when comparing the specified Statistic and Threshold | `string` | `null` | no |
| <a name="input_create_event_rule"></a> [create\_event\_rule](#input\_create\_event\_rule) | Controls if cloudwatch event rule should be created | `bool` | `false` | no |
| <a name="input_create_metric_alarm"></a> [create\_metric\_alarm](#input\_create\_metric\_alarm) | Controls if cloudwatch metric alarm should be created | `bool` | `false` | no |
| <a name="input_create_metric_filter"></a> [create\_metric\_filter](#input\_create\_metric\_filter) | Controls if cloudwatch metric filter should be created | `bool` | `false` | no |
| <a name="input_cross_account_role_name"></a> [cross\_account\_role\_name](#input\_cross\_account\_role\_name) | The name of the cloudwath cross-account role | `string` | `"CloudWatch-CrossAccountSharingRole"` | no |
| <a name="input_datapoints_to_alarm"></a> [datapoints\_to\_alarm](#input\_datapoints\_to\_alarm) | The number of datapoints that must be breaching to trigger the alarm. | `number` | `1` | no |
| <a name="input_evaluate_low_sample_count_percentiles"></a> [evaluate\_low\_sample\_count\_percentiles](#input\_evaluate\_low\_sample\_count\_percentiles) | The alarm state will be ignore or evaluate during periods with too few data points to be statistically significant for alarms based on percentiles | `string` | `null` | no |
| <a name="input_evaluation_periods"></a> [evaluation\_periods](#input\_evaluation\_periods) | The number of periods over which data is compared to the specified threshold | `string` | `null` | no |
| <a name="input_event_description"></a> [event\_description](#input\_event\_description) | The description of the rule for the event rule | `string` | `null` | no |
| <a name="input_event_is_enabled"></a> [event\_is\_enabled](#input\_event\_is\_enabled) | Should be false to indicate whether the event rule is not enabled | `bool` | `true` | no |
| <a name="input_event_name"></a> [event\_name](#input\_event\_name) | A name for the event rule | `string` | `""` | no |
| <a name="input_event_pattern"></a> [event\_pattern](#input\_event\_pattern) | The event pattern described a JSON object | `string` | `null` | no |
| <a name="input_event_role_arn"></a> [event\_role\_arn](#input\_event\_role\_arn) | The Amazon Resource Name (ARN) associated with the role that is used for target | `string` | `""` | no |
| <a name="input_event_schedule"></a> [event\_schedule](#input\_event\_schedule) | The scheduling expression for the event rule | `string` | `null` | no |
| <a name="input_extended_statistic"></a> [extended\_statistic](#input\_extended\_statistic) | The percentile statistic for the metric associated with the alarm | `string` | `null` | no |
| <a name="input_filter_name"></a> [filter\_name](#input\_filter\_name) | A name for the metric filter | `string` | `""` | no |
| <a name="input_filter_pattern"></a> [filter\_pattern](#input\_filter\_pattern) | A valid CloudWatch Logs filter pattern for extracting metric data out of ingested log events | `string` | `null` | no |
| <a name="input_insufficient_data_actions"></a> [insufficient\_data\_actions](#input\_insufficient\_data\_actions) | The list of actions (ARNs) to execute when this alarm transitions into an INSUFFICIENT\_DATA state | `list(string)` | `[]` | no |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | The name of the log group to associate the metric filter with | `string` | `null` | no |
| <a name="input_metric_name"></a> [metric\_name](#input\_metric\_name) | The name for the alarm's associated metric | `string` | `null` | no |
| <a name="input_metric_transformation_default_value"></a> [metric\_transformation\_default\_value](#input\_metric\_transformation\_default\_value) | The value to emit when a filter pattern does not match a log event | `string` | `0` | no |
| <a name="input_metric_transformation_name"></a> [metric\_transformation\_name](#input\_metric\_transformation\_name) | The name of the CloudWatch metric to which the monitored log information should be published | `string` | `null` | no |
| <a name="input_metric_transformation_namespace"></a> [metric\_transformation\_namespace](#input\_metric\_transformation\_namespace) | The destination namespace of the CloudWatch metric | `string` | `null` | no |
| <a name="input_metric_transformation_value"></a> [metric\_transformation\_value](#input\_metric\_transformation\_value) | What to publish to the metric | `number` | `1` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace for the alarm's associated metric | `string` | `null` | no |
| <a name="input_ok_actions"></a> [ok\_actions](#input\_ok\_actions) | The list of actions (ARNs) to execute when this alarm transitions into an OK state | `list(string)` | `[]` | no |
| <a name="input_period"></a> [period](#input\_period) | The period in seconds over which the specified statistic is applied | `string` | `null` | no |
| <a name="input_sharing_account"></a> [sharing\_account](#input\_sharing\_account) | Controls if cloudwatch cross-account should be created | `bool` | `false` | no |
| <a name="input_statistic"></a> [statistic](#input\_statistic) | The statistic to apply to the alarm's associated metric | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | n/a | yes |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | The value against which the specified statistic is compared | `string` | `null` | no |
| <a name="input_treat_missing_data"></a> [treat\_missing\_data](#input\_treat\_missing\_data) | Sets how this alarm is to handle missing data points | `string` | `"notBreaching"` | no |
| <a name="input_unit"></a> [unit](#input\_unit) | The unit for the alarm's associated metric | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_cross_account_arn"></a> [cloudwatch\_cross\_account\_arn](#output\_cloudwatch\_cross\_account\_arn) | The ARN of the cloudwatch cross-account role |
| <a name="output_cloudwatch_event_rule_arn"></a> [cloudwatch\_event\_rule\_arn](#output\_cloudwatch\_event\_rule\_arn) | The ARN of the cloudwatch event rule |
| <a name="output_cloudwatch_event_rule_id"></a> [cloudwatch\_event\_rule\_id](#output\_cloudwatch\_event\_rule\_id) | The name of the event rule |
| <a name="output_cloudwatch_log_metric_filter_id"></a> [cloudwatch\_log\_metric\_filter\_id](#output\_cloudwatch\_log\_metric\_filter\_id) | The name of the metric filter |
| <a name="output_cloudwatch_metric_alarm_arn"></a> [cloudwatch\_metric\_alarm\_arn](#output\_cloudwatch\_metric\_alarm\_arn) | The ARN of the cloudwatch metric alarm |
| <a name="output_cloudwatch_metric_alarm_id"></a> [cloudwatch\_metric\_alarm\_id](#output\_cloudwatch\_metric\_alarm\_id) | The ID of the health check |
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
