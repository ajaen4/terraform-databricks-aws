# Databricks - AWS


## Introduction

This project deploys an architecture in AWS for Databricks to use, resulting in a secure and functional environment to be able to work with Databricks. The tool used for this deployment is Terraform.

## Architecture

![Alt text](images/architecture-overview.png?raw=true "Title")

## Documentation

Articles:
 - [First article: Subscription types, High Level Architecture, Networking, Identity and Access Management](https://bluetab.net/en/databricks-sobre-aws-una-perspectiva-de-arquitectura-parte-1/)
 - Second article: Security, Scalability, Logging and Monitoring and Deployment
 - Medium article: deep dive on deployment

## Requirements

- You must own an AWS account and have an Access Key to be able to authenticate.

- 2 SSM parameters must be available with the necessary credentials for the Databricks account:
    - 1 array type parameter with the Databricks account and username in that order
    - 1 string type parameter with the Databricks account password

- Versions:
    - databrickslabs/databricks = 0.3.9
    - hashicorp/aws = 3.70.0

## Infrastructure deployed

This code will deploy the following infraestructure inside AWS:
- 1 VPC
- 3 VPC Endpoints
- 2 KMS keys
- 3 buckets for the datalake (raw, prepared and trusted) and 1 root bucket (for Databricks internal files, part of DBFS)
- 2 buckets for logging (Databricks logging and infrastructure logging)
- 1 EC2 cluster
- 1 cross account role for Databricks
- 1 meta instance profile for the cluster to assume
- 2 data roles for the meta instance profile to assume (read or read and write on all datalake buckets)
- 1 role with Glue permissions
- 1 role to access the Databricks logging bucket for the cluster
- 1 Databricks workspace
- 2 Databricks user groups (read only or read and write on all datalake buckets)

## Installation

Follow the instructions [here](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started#:~:text=popular%20package%20managers.-,%C2%BB,Install%20Terraform,-Manual%20installation) to install terraform

Follow the instructions [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) to install the AWS CLI

## Infrastructure deployment

To be able to deploy the infrastructure it's necessary to fill in the variables file ("vars/databricks.tfvars") and the backend config for the remote state ("terraform.tf")

To deploy, the following commands must be run:

```bash
terraform init
terraform <plan/apply/destroy> -var-file=vars/<file-name>.tfvars

# Example
terraform init
terraform apply -var-file=vars/databricks.tfvars
```

## Scripts 

- reset_tokens: When the tokens expire the script "reset_tokens.sh" must be run to reset them. This script deploys only the "databricks_provisioning" module in order to obtain new valid tokens. This is necessary because Terraform uses these tokens to authenticate when deploying/updating other resources in the "databricks_management" module, and even though it knows it must update the tokens, it first has to update the infrastructure state for this module. Running this script will avoid this update operation on the "databricks_management", being able to update the tokens.

- sleep_network_infrastructure: This is an optional script to avoid incurring in infrastructure costs when the deployment is not being used. It destroys the NAT used and the VPC Endpoints. To be able to use the deployment again just run "terraform apply -var-file=vars/<file-name>.tfvars"

## To take into account

To take into account:

- There are instances of the Databricks provider with different authentications, this is due to the fact that the provider needs different types of authentication for different resources (account based, Personal Access Token based, Service Ppal based)
- The Service Principal has limitations, this is why we must use the Personal Access Token authentication in some cases. The limitations are the following:
    - It can't create clusters (but it can manage them)
    - It can't create files in the DBFS
- Encryption: All persistence layers are encrypted (S3 and EBS) and the option to add client-side encryption is available. To do this it's necessary to set the variables "dbfs_client_side_enc" and "datalake_client_side_enc" to true depending on the use case you want to implement.

## Posible upgrades

- Adding Private Links to be able to implement communications through private channels (please note that even when using public channels the communication is encrypted)
- Add SSO (Single Sign-on)

## License

MIT License - Copyright (c) 2021 The databricks-aws Authors.