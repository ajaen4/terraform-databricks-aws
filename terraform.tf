terraform {
  backend "s3" {
    key            = "databricks-test.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
    bucket         = "euw1-bluetab-general-tfstate-pro"
  }
}
