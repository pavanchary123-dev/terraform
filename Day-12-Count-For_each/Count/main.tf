# Basic count example
# resource "aws_instance" "name" {
#   ami = "ami-0b6c6ebed2801a5cb"
#   instance_type = "t2.micro"
#   count = 2
#   tags = {
#     Name="dev"
#   }
# }
##### count example-2 ########
# resource "aws_instance" "name" {
#   ami = "ami-0b6c6ebed2801a5cb"
#   instance_type = "t3.micro"
#   count = 2
#   tags = {
#     Name="dev-${count.index}"
#   }
# }

#### count with variable ######

variable "env" {
    type = list(string)
    default = [ "dev","prod"]   # ["dev","test","prod"]
  
}

resource "aws_instance" "name" {
    ami = "ami-07860a2d7eb515d9a"
    instance_type = "t2.micro"
    count = length(var.env)
    # tags = {
    #   Name = "dev"
    # }
  tags = {
      Name = var.env[count.index]
    }
}