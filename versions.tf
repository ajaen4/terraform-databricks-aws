terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.3.9"
    }
    aws = {
      source = "hashicorp/aws"
      version = "3.49.0"
    }    
  }
}