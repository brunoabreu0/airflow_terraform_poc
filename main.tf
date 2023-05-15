terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.57"
    }
  }

  required_version = ">= 1.3.8"

  backend "s3" {
    bucket = "dbt-tf-poc"
    key    = "airflow-tf-poc-state"
    region = "eu-west-1"
  }
}

module "airflow" {
 source = "./airflow"
}
