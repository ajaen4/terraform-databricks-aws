# Databricks - AWS


## Introduction

This project deploys an architecture in AWS for Databricks to use, resulting in a secure and functional environment to be able to work with Databricks. The tool used for this deployment is Terraform.

[Documentation](https://docs.google.com/document/d/1ZaPrrdw3MCwOaSPQldkr9Z0C2WaQjK2Q1mHfA5BX6iY/edit#heading=h.juzm8wf61oip)

## Architecture

![Alt text](images/arquitectura_simple.png?raw=true "Title")

## Requirements

- databrickslabs/databricks = 0.3.9
- hashicorp/aws = 3.70.0

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