module "customer_managed_vpc" {
  source = "./modules/aws-vpc"

  create_vpc                       = var.customer_managed_vpc.create_vpc
  name                             = var.customer_managed_vpc.vpc_name

  cidr                             = var.customer_managed_vpc.cidr
  public_azs                       = var.customer_managed_vpc.public_azs
  private_azs                      = var.customer_managed_vpc.private_azs
  private_subnets                  = var.customer_managed_vpc.private_subnets
  public_subnets                   = var.customer_managed_vpc.public_subnets

  enable_nat_gateway               = var.customer_managed_vpc.enable_nat_gateway
  single_nat_gateway               = var.customer_managed_vpc.single_nat_gateway
  one_nat_gateway_per_az           = var.customer_managed_vpc.one_nat_gateway_per_az

  default_vpc_enable_dns_hostnames = var.customer_managed_vpc.default_vpc_enable_dns_hostnames
  default_vpc_enable_dns_support   = var.customer_managed_vpc.default_vpc_enable_dns_support

  enable_flow_log                  = var.customer_managed_vpc.enable_flow_log

  enable_dns_hostnames             = var.customer_managed_vpc.enable_dns_hostnames
  enable_dns_support               = var.customer_managed_vpc.enable_dns_support

  # Default security group
  manage_default_security_group    = var.customer_managed_vpc.manage_default_security_group
  default_security_group_name      = var.customer_managed_vpc.default_security_group_name
  

  default_security_group_egress = [{
    cidr_blocks = "0.0.0.0/0"
  }]

  default_security_group_ingress = [{
    description = "Allow all internal TCP and UDP"
    self        = true
  }]

  tags = var.tags
}

module "vpc_endpoints" {
  source = "./modules/vpc-endpoints"

  vpc_id             = module.customer_managed_vpc.vpc_id
  security_group_ids = [module.customer_managed_vpc.default_security_group_id]

  endpoints = {
    s3 = {
      service         = "s3"
      service_type    = "Gateway"
      route_table_ids = flatten([module.customer_managed_vpc.private_route_table_ids,
                                module.customer_managed_vpc.public_route_table_ids])
      tags            = { 
        Name = "${var.prefix}-s3-vpc-endpoint" 
        }
    },
    sts = {
      service             = "sts"
      private_dns_enabled = true
      subnet_ids          = module.customer_managed_vpc.private_subnets
      tags                = {
        Name = "${var.prefix}-sts-vpc-endpoint"
      }
    },
    kinesis-streams = {
      service             = "kinesis-streams"
      private_dns_enabled = true
      subnet_ids          = module.customer_managed_vpc.private_subnets
      tags                = {
        Name = "${var.prefix}-kinesis-vpc-endpoint"
      }
    }, 
  }
}