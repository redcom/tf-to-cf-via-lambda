## Include the `root-terragrunt.hcl` file
include {
  path = find_in_parent_folders("root-terragrunt.hcl")
}

locals {
  ## Load variables from hierarchy
  global_modules = read_terragrunt_config(find_in_parent_folders("global-modules.hcl")).locals

  ## load variables for this solution
  demicon_vars = read_terragrunt_config(find_in_parent_folders("demicon.hcl")).locals

  # Set module name here, path and version are controlled by `global-modules.hcl`
  module_name = "expose-terraform-state"

  # Module loader code
  module_data     = local.global_modules.modules[local.module_name]
  module_is_local = try(local.module_data.local, false)
  module_path     = local.module_data.path
  module_basepath = local.global_modules.module_basepath_local
  module_source   = "${local.module_basepath}/${local.module_path}?ref=${local.module_data.ref}"
}

## Terragrunt will copy the Terraform code specified by the source parameter, along with any files in the
## working directory, into a temporary folder, and execute your Terraform commands in that folder
terraform {
  source = local.module_source
}

## Use Terragrunt `dependency` blocks to define module dependencies and to pass outputs between modules
## see https://terragrunt.gruntwork.io/docs/features/execute-terraform-commands-on-multiple-modules-at-once/#passing-outputs-between-modules
##
## Use `mock_outputs` block to supply mocks (simulated variables) of Terragrunt module dependency outputs
## This allows Terragrunt's `validate-all` and `plan-all` commands to work without having applied the module first
## see https://terragrunt.gruntwork.io/docs/features/execute-terraform-commands-on-multiple-modules-at-once/#unapplied-dependency-and-mock-outputs


dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    "vpc_id" = "mock-default-1"
  }
}


## These are the variables we have to pass in to use the module specified in the terragrunt configuration above
## Additionally, Terragrunt will fill in everything from the 'inputs' block in the `root-terragrunt.hcl` file
inputs = {
  vpc_id = try(dependency.vpc.outputs.vpc_id, "mock-vpc-id")

  tags = {
    "TerraformModuleName" = "${local.module_name}"
  }
}
