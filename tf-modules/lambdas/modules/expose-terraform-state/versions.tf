# pin version of aws provider
terraform {
  required_version = ">= 1.2.5"

  required_providers {
    source  = "hashicorp/aws"
    version = ">= 4.22.0"
  }
}

