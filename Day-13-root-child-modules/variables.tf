#### VPC #######
variable "cidr_block" {
  default = "10.0.0.0/16"
}
variable "subnet_1_cidr" {
  default = "10.0.1.0/24"
}
variable "subnet_2_cidr" {
  default = "10.0.2.0/24"
}
variable "az1" {
 default = "us-east-1a"
}
variable "az2" {
 default =  "us-east-1b"
}

###### Ec2 ####
variable "ami_id" {
  default = "ami-0c1fe732b5494dc14"
}
variable "instance_type" {
  default = "t2.micro"
}

###### RDS ##########
 variable "instance_class" {
   default = "db.t3.micro"
 }
 variable "db_name" {
   default ="mydb"
 } 
 variable "db_user" {
   default = "admin"
 }
 variable "db_password" {
   default = "Admin12345"
 }

 ##### S3 ########
variable "bucket" {
  default = "wertyuisdfghxcfvgh"
}