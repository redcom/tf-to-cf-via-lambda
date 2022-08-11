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

  merged = merge(
    local.temp_merged,
    {}
  )
}


