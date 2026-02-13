provider "aws" {
  
}

# used for the "default-workspace"

# resource "aws_s3_bucket" "name" {
#   bucket = "ecuhuouohoooo"
# }

# # It was used by "dev-workspace"
resource "aws_instance" "name" {
  ami = var.ami_id
  instance_type =var.instance_type
  tags = {
    Name="b-dev"
  }
}

# it was used by "test-workspace"
# resource "aws_instance" "name" {
#   ami = var.ami_id
#   instance_type = var.instance_type
#   tags = {
#     Name="b-test"
#   }
# }