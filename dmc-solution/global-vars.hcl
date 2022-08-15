##-----------------------------------------------------------------------------
## Global variables
## These are automatically loaded by `global.hcl`
##-----------------------------------------------------------------------------

locals {
  # NOTE: update versions in `root-terragrunt.hcl`, too!
  terraform_version  = "1.2.5"
  terragrunt_version = "0.38.5"

  # Provider configuration
  provider_region = "eu-central-1"

  account_name = "devsekops"
  account_id   = "881814166474"


  # Provisioning roles explnation for the sake of exercise
  # `OrganizationAccountAccessRole` is an AWS managed role used for infra deployment via terraform.

  provisioning_role_name_automation    = "DevSekOps_Admin" # Assumed by Terragrunt in automation 
  provisioning_session_name_automation = "terragrunt-in-automation"
  provisioning_role_names              = [local.provisioning_role_name_automation]

  # save local copy of variable which can be changed based on ROLE name received from environment variables
  remote_state_role_name    = local.provisioning_role_name_automation
  remote_state_session_name = local.provisioning_session_name_automation


  # Remote state backend configuration
  remote_state_region      = "us-east-2" // where the remote state bucket will be stored
  remote_state_bucket_name = "infra-global-terraform-state-bucket"
  remote_state_bucket_arn  = "arn:aws:s3:::${local.remote_state_bucket_name}"
  remote_state_bucket_acl  = "bucket-owner-full-control"
  remote_state_role_arn    = "arn:aws:iam::${local.account_id}:role/${local.remote_state_role_name}"



}

