provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "name" {
  bucket = "ooksdkdsdskskds"
}

resource "aws_instance" "name" {
  ami = "ami-0b6c6ebed2801a5cb"
  instance_type = "t2.micro"
  tags = {
    Name="ec2-terraform"
  }
}

# when you use taint to a particular resource that resource will be destroyed and recreated ,
# we use this taint method for remote-exce also so that we no need to use triggers.