locals {
  # Remote duplicate availability zones
  azs_distinct = distinct(var.azs)

  # Use `module.this.vpc_secondary_cidr_blocks` to give a hint to Terraform that subnets should be deleted before secondary CIDR blocks can be freed
  # And vice-versa: subnets can only be created after secondary CIDR blocks have been associated with the VPC
  # secondary_cidr_blocks for VPC expantion
  vpc_id = concat([module.this.vpc_id], module.this.vpc_secondary_cidr_blocks)[0]
}

################################################################################
# VPC Module
################################################################################

## pinne module version for avoiding sideefects
module "this" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v3.14.2"

  ## Conditional VPC creation
  create_vpc = var.create_vpc

  ## VPC Name
  name = var.name

  ## Primary and secondary CIDR blocks
  cidr                  = var.cidr
  secondary_cidr_blocks = var.secondary_cidr_blocks

  ## DNS
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  ## Availability zones and subnets
  azs              = var.azs
  public_subnets   = var.public_subnets
  database_subnets = var.database_subnets
  private_subnets  = var.private_subnets


  ## Route table creation
  create_database_subnet_route_table = var.create_database_subnet_route_table

  ## NAT gateway
  enable_nat_gateway = var.enable_nat_gateway

  ## Internet gateway
  create_igw = var.create_igw

  ## Tags
  tags                 = var.tags
  vpc_tags             = var.vpc_tags
  igw_tags             = var.igw_tags
  public_subnet_tags   = var.public_subnet_tags
  private_subnet_tags  = var.private_subnet_tags
  database_subnet_tags = var.database_subnet_tags
}


