

provider "aws" {
  region = var.region
#   profile = "dev"
}
module "vpc" {
  source = "../../modules/vpc"
  cidr_block           = var.vpc_cidr
  availability_zone_1  = var.availability_zone_1
  availability_zone_2  = var.availability_zone_2
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr
  env                  = "vpc-${var.env}"
}

module "ec2" {
  source             = "../../modules/ec2"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  env                = var.env
  subnet_id          = module.vpc.public_subnet_1_id
} 
module "sg" {
   source            = "../../modules/SG"
   vpc_id            = module.vpc.vpc_id
   env               = var.env
}

module "rds" {
  source = "../../modules/rds"

  instance_class     = var.rds_instance_class
  db_name            = var.rds_db_name
  db_user            = var.rds_db_user
  db_password        = var.rds_db_password
  env                = var.env
  vpc_id             = module.vpc.vpc_id
  public_subnet_1_id = module.vpc.public_subnet_1_id
  public_subnet_2_id = module.vpc.public_subnet_2_id

  security_group_id  = module.sg.security_group_id
}

