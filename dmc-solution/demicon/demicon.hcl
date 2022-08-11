##-----------------------------------------------------------------------------
## Set account-wide variables
## These are automatically loaded by all `terragrunt.hcl` files
##-----------------------------------------------------------------------------
locals {

  current_dir = get_terragrunt_dir()

  ## Availability zones and corresponding subnets
  azs = ["us-east-1a", "us-east-1b"]

  tags = {
    Solution = "Demicon"
    Owner    = "redcom@gmail.com"
  }

  ## configuration variables to create a VPC
  vpc = {
    name             = "simple-vpc"
    create_vpc       = true
    cidr             = "192.1.0.0/16"
    azs              = local.azs
    public_subnets   = ["192.1.0.0/23", "192.1.2.0/23"]
    private_subnets  = ["192.1.8.0/22", "192.1.12.0/22"]
    database_subnets = ["192.1.20.0/24", "192.1.21.0/24"]

    public_subnet_tags   = { Name = "net:sn:pub" }
    private_subnet_tags  = { Name = "net:sb:priv" }
    database_subnet_tags = { Name = "net:sb:data" }
    igw_tags             = { Name = "net:igw:simple-vpc" }
    vpc_tags             = { Name = "simple-vpc" }
    tags                 = merge(local.tags, vpc_tags)
  }

  ## configuration variables to create an ALB load balancer
  alb = {
    create_lb          = true
    name               = "simple-alb"
    load_balancer_type = "application"
    subnets            = [] # this will be populated by the VPC module
    vpc_id             = "" # this will be populated by the VPC MODULE
    security_groups    = [] # this will be populated by the VPC MODULE

    lb_tags = { Name = "simple-alb" }
    tags    = merge(local.tags, lb_tags)
  }

  ## configuration variable to create lambda for exposing the terraform state
  expose_terraform_state = {
    create_lambda              = true
    environment_variables      = {}
    authorization_type         = "AWS_IAM"
    create_lambda_function_url = true

    role_tags = { Name = "ExposeTerraformStateLambdaRole" }
    tags      = merge(local.tags, {})
  }

}
