# Databricks - AWS


## Introduction

This project deploys an architecture in AWS for Databricks to use, resulting in a secure and functional environment to be able to work with Databricks. The tool used for this deployment is Terraform.

## Architecture

![Alt text](images/architecture-overview.png?raw=true "Title")

## Documentation

Articles:
 - [First article: Subscription types, High Level Architecture, Networking, Identity and Access Management](https://bluetab.net/en/databricks-sobre-aws-una-perspectiva-de-arquitectura-parte-1/)
 - [Second article: Security, Scalability, Billing and Deployment](https://www.bluetab.net/en/databricks-on-aws-an-architectural-perspective-part-2/)
 - [Medium article: Deploy Databricks on AWS with Terraform](https://medium.com/@a.jaenrev/deploy-databricks-on-aws-with-terraform-71772b4a04dc)

## Requirements

- You must own an AWS account and have an Access Key to be able to authenticate.

- 2 SSM parameters must be available with the necessary credentials for the Databricks account:
    - 1 array type parameter with the Databricks account and username in that order
    - 1 string type parameter with the Databricks account password

- Versions:
    - Terraform = 1.1.2
    - databrickslabs/databricks = 0.3.9
    - hashicorp/aws = 3.70.0

## Infrastructure deployed

This code will deploy the following infraestructure inside AWS:
- 1 VPC
- 3 Private Subnets in 3 different AZs
- 1 Public Subnet
- 1 NAT 
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

Follow the instructions [here](https://cloudaffaire.com/faq/how-to-install-jq/) to install jq

## bucket and DynamoDB for terraform state deployment

```bash
export AWS_ACCESS_KEY_ID=XXXX
export AWS_SECRET_ACCESS_KEY=XXXX
export AWS_DEFAULT_REGION=eu-west-1

cd bootstraper-terraform
terraform init
terraform <plan/apply/destroy> -var-file=vars/bootstraper.tfvars

# Example
cd bootstraper-terraform
terraform init
terraform apply -var-file=vars/bootstraper.tfvars
```

It is important that you choose wisely the variables declared in the "bootstraper-terrafom/vars/bootstraper.tfvars" file because the bucket name is formed using these.

There will be an output printed on the terminal's screen, this could be an example:

```bash
state_bucket_name = "eu-west-1-bluetab-cm-vpc-tfstate"
```

Please copy it, we will be using it in the next chapter.

## Infrastructure deployment

To be able to deploy the infrastructure it's necessary to fill in the variables file ("vars/databricks.tfvars") and the backend config for the remote state ("terraform.tf")

To deploy, the following commands must be run:

```bash
export AWS_ACCESS_KEY_ID=XXXX
export AWS_SECRET_ACCESS_KEY=XXXX
export AWS_DEFAULT_REGION=eu-west-1
export BACKEND_S3=<VALUE_COPIED_PREVIOUS_CHAPTER>

terraform init -backend-config="bucket=${BACKEND_S3}"
terraform <plan/apply/destroy> -var-file=vars/<file-name>.tfvars
```

We will use the value copied in the previous chapter, the state bucket name, to give the variable BACKEND_S3 its value.

It is important that you choose the prefix variable in the "vars/databricks.vars" wisely because it will be used to name all the infrastructure, including the buckets. These buckets must have a global unique name in AWS, so if you get an error deploying it is most likely that this is due to the fact that these names are already being used.

## Scripts 

- reset_tokens: When the tokens expire the script "reset_tokens.sh" must be run to reset them. This script deploys only the "databricks_provisioning" module in order to obtain new valid tokens. This is necessary because Terraform uses these tokens to authenticate when deploying/updating other resources in the "databricks_management" module, and even though it knows it must update the tokens, it first has to update the infrastructure state for this module. Running this script will avoid this update operation on the "databricks_management", being able to update the tokens.

- sleep_network_infrastructure: This is an optional script to avoid incurring in infrastructure costs when the deployment is not being used. It destroys the NAT used and the VPC Endpoints. To be able to use the deployment again just run "terraform apply -var-file=vars/databricks.tfvars"

These scripts must be run from the root folder.

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

## Troubleshooting

- It is important to personalize the variables used well, there can be conflicts with the names because AWS needs the names of some resources to be globally unique. If you get an error when deploying, check the error is not due to a name conflict of the type: "bucket already exists".
- When destroying the infrastructure, the file resource we use to contain an init script for the cluster can fail to be deleted. Run the following command to remove it from state management and try to destroy the infrastructure again:

```bash
terraform state rm module.databricks_management.databricks_dbfs_file.core_site_config
```

## License

MIT License - Copyright (c) 2021 The databricks-aws Authors.