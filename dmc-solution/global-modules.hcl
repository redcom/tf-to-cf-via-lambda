##-----------------------------------------------------------------------------
## Global module variables
## These are automatically loaded by `global.hcl`
## local = true means it will use the module defined in the folder tf-modules
## local = false should be use when the module definition is in GIT or public repositories or registers
##-----------------------------------------------------------------------------

locals {
  ## Terraform module paths and versions/references in order to securely and reliable use terraform modules and easy the upgrade process
  module_basepath_local = "${get_terragrunt_dir()}/../tf-modules"
  modules = {
    "simple-vpc"             = { local = true, path = "vpc/modules/simple-vpc" }
    "alb"                    = { local = true, path = "lb/modules/alb" }
    "expose-terraform-state" = { local = true, path = "lambdas/modules/expose-terraform-state" }

  }
}
