##------------------
## Read and merge all global variables
##-----------------

locals {
  ## Order matters
  temp_merged = merge(
    read_terragrunt_config("${get_parent_terragrunt_dir()}/global-modules.hcl").locals,
    read_terragrunt_config("${get_parent_terragrunt_dir()}/global-tags.hcl").locals,
    read_terragrunt_config("${get_parent_terragrunt_dir()}/global-vars.hcl").locals,
  )
  provisioning_role_name    = local.temp_merged.provisioning_role_names[0]
  provisioning_session_name = local.temp_merged.provisioning_session_name_automation

  merged = merge(
    local.temp_merged,
    {
      provisioning_role_name    = local.provisioning_role_name
      provisioning_session_name = local.provisioning_session_name
    }
  )
}


