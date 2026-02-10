provider "aws" {
  
}

module "aws_instance" {
  source = "../../Day-7-modules"
  ami_id = "ami-0532be01f26a3de55"
  instance_type = "t2.micro"
  Name = "ec2-1"
  
}