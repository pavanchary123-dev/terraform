locals {
  ami=var.ami_id
  instance_type=var.instance_type
  tags=var.instance_name
}

# resource "aws_instance" "name" {
#   ami = local.ami
#   instance_type =local.instance_type
#    tags = {
#      Name=local.tags
#    }
# }



variable "environment" {
  default = "dev"
}

variable "project" {
  default = "billing"
}

locals {
  name_prefix = "${var.project}-${var.environment}"
}

resource "aws_instance" "app" {
  ami           = local.ami
  instance_type = local.instance_type

  tags = {
    Name = "${local.name_prefix}-server"
  }
}
