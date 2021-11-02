# AWS SNS

Terraform module to set SNS topics and subscriptions by email.

## Dependencies

No dependencies.

## Usage

Just import with **source** the module.

### Example Usage

    module "aws-sns" {
        source = "git::ssh://git@code.gniinnova.com/activos-it/aws-sns?ref=X.X.X"

        tags             = "${var.tags}"
        emails            = ["account@email.com"]
        name             = "mysns"
    }

## Parameters

- **tags**
  - **project**: *Required*. Project name.
  - **environment**: *Required*. Environment (dev, pre, prod, etc.).
- **emails**: *Required* List of emails that you want to receive notifications. If empty list, it won't create any subscription.
- **name**: *Required*. Name of the resource.
- **kms_master_key_id**: *Required* KMS id

## Outputs

- **arn**: Created topic ARN.
