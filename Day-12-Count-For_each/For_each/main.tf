provider "aws" {
  region = "us-east-1"
}

variable "env" {
    type = list(string)
    default = [ "dev","prod"]  # [ "dev","test","prod"]
  
}
resource "aws_instance" "name" {
    ami = "ami-07860a2d7eb515d9a"
    instance_type = "t2.micro"
    for_each = toset(var.env)  ### for_each = toset(var.env)
    # tags = {
    #   Name = "dev"
    # }
  tags = {
      Name = each.value
    }
}