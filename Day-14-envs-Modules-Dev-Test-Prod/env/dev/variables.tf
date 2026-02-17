variable "vpc_cidr" {}
variable "public_subnet_1_cidr" {}
variable "public_subnet_2_cidr" {}
variable "availability_zone_1" {}
variable "availability_zone_2" {}
variable "instance_type" {}
variable "env" {}
variable "ami_id" {}
variable "region" {}
#------- Rds---------
variable "rds_instance_class"  {}
variable "rds_db_name"  {}
variable "rds_db_user"  {}
variable "rds_db_password"  {}