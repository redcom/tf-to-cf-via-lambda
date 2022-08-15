# pin version of aws provider
terraform {
  required_version = ">= 1.2.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.22.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.2.3"
    }
    external = {
      source  = "hashicorp/external"
      version = ">= 2.2.2"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.1.1"
    }
  }
}

