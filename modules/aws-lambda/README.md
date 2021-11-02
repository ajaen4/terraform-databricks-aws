# AWS Lambda Function Terraform Module

Terraform module which creates a Lambda Function on AWS.

* [AWS Lambda Function](hhttps://www.terraform.io/docs/providers/aws/r/lambda_function.html)

## Terraform versions

Only Terraform 0.14 is supported.

## Usage

```hcl
module "lambda" {
  source = "git::ssh://git@vliamd634.cloud.bankia.int:7999/ter/aws-lambda.git?ref=v0.1.0"

  [...]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14 |
| aws | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_lambda | Controls if a Lambda Function should be created | `bool` | `true` | no |
| description | Description of what your Lambda Function does | `string` | `""` | no |
| environment | The Lambda environment's configuration settings | `list(map(string))` | <pre>[<br>  {<br>    "foo": "bar"<br>  }<br>]</pre> | no |
| filename | The path to the function's deployment package | `string` | `null` | no |
| function\_name | A unique name for your Lambda Function | `string` | n/a | yes |
| handler | The function entrypoint in your code | `string` | n/a | yes |
| kms\_key\_arn | The ARN for the KMS encryption key | `string` | `null` | no |
| lambda\_permissions | The principals who is getting the permission of trigger this Lambda Function | `string` | `null` | no |
| layers | List of Lambda Layer Version ARNs (maximum of 5) | `list(string)` | `[]` | no |
| memory\_size | Amount of memory in MB your Lambda Function can use at runtime | `number` | `128` | no |
| publish | Should be true to publish creation/change as new Lambda Function | `bool` | `false` | no |
| reserved\_concurrent\_executions | The amount of reserved concurrent executions for this Lambda Function | `number` | `-1` | no |
| retention\_in\_days | The number of days that you want to retain log events | `number` | `30` | no |
| runtime | The Lambda Function runtime | `string` | n/a | yes |
| source\_code\_hash | Must be set to a base64-encoded SHA256 hash of the package file | `string` | `null` | no |
| tags | A map of tags to add to all resources | `map(string)` | n/a | yes |
| timeout | The amount of time your Lambda Function has to run in seconds | `number` | `3` | no |
| triggers\_arns | List of ARNs to invoke your function this Lambda Function | `list(string)` | `[]` | no |
| vpc\_config | VPC config that allow your function to access the VPC | <pre>list(object({<br>    security_group_ids = list(string)<br>    subnet_ids         = list(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| lambda\_arn | The ARN of the Lambda Function |
| lambda\_cloudwatch\_log\_group | The ARN of the log group used by Lambda Function |
| lambda\_iam\_role\_arn | The ARN of the IAM role used by Lambda Function |
| lambda\_iam\_role\_name | The name of the IAM role used by Lambda Function |
| lambda\_invoke\_arn | The ARN to be used for invoking Lambda Function from API Gateway |
| lambda\_last\_modified | The date Lambda Function was last modified |
| lambda\_name | The name of the Lambda Function |
| lambda\_qualified\_arn | The ARN of the Lambda Function version |
| lambda\_source\_code\_size | The size in bytes of the Lambda Function zip file |
| lambda\_version | Latest published version of the Lambda Function |

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
