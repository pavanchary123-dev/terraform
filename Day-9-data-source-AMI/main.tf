provider "aws" {
    access_key = "AKIA6KJBJD7UEPLJO25J"
    secret_key = "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"
    region = "us-east-1"
  
}
  
data "aws_subnet" "name" {
    filter {
    name   = "tag:Name"
    values = ["dev"] # insert value here
  }
}
# data "aws_ami" "amzlinux" {
#   most_recent = true
#   owners = [ "amazon" ]
#   filter {
#     name ="name"
#     values = [ "amzn2-ami-hvm-*-gp2" ]
#   }
#   filter {
#     name = "name"
#     values = [ "amzn2-ami-hvm-*-gp2" ]
#   }
#              filter {
#     name = "root-device-type"
#     values = [ "ebs" ]
#   }
#         filter {
#     name = "virtualization-type"
#     values = [ "hvm" ]
#   }
#   filter {
#     name = "architecture"
#     values = [ "x86_64" ]
#   }
# }
data "aws_ami" "amzlinux" {
  most_recent = true
  owners = [ "self" ]
  filter {
    name = "name"
    values = [ "new" ]
  }
}
resource "aws_instance" "name1" {
    ami=data.aws_ami.amzlinux.id
    instance_type = "t2.micro"
    subnet_id = data.aws_subnet.name.id

}