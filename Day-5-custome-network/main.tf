#creating vpc
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name="custom-vpc"
    }
}
# subnets creation
resource "aws_subnet" "name" {
    vpc_id =aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name="subnet-1-pub"
    }
}
resource "aws_subnet" "name2" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name="subnet-prvt"
    }
}
#IG creation
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
      Name="IG"
    }
}
#Route gateway
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.name.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.name.id
    }
    tags = {
      Name="RT"
    }
}
# RT_subnet association
resource "aws_route_table_association" "name" {
    route_table_id = aws_route_table.name.id
    subnet_id = aws_subnet.name.id
}
#sg-creation
resource "aws_security_group" "name" {
    vpc_id = aws_vpc.name.id
    name = "allow"
    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "Tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}
#Ec2 creation public
resource "aws_instance" "name" {
    ami = "ami-0532be01f26a3de55"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.name.id
    vpc_security_group_ids = [ aws_security_group.name.id ]
    tags = {
      Name="ec2-pub"
    }
    associate_public_ip_address = true   #it assign public ip
}
# creating prvt Ec2
resource "aws_instance" "name2" {
    ami = "ami-0532be01f26a3de55"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.name2.id
    vpc_security_group_ids = [ aws_security_group.name.id ]
    tags = {
      Name="ec2-prvt"
    }
  
}
#to create NAT frst we need to create "elastic_ip"
#creating E_ip
resource "aws_eip" "name" {
    domain = "vpc"
}
# NAT gateway
resource "aws_nat_gateway" "name" {
    subnet_id = aws_subnet.name2.id
    allocation_id = aws_eip.name.id
    tags = {
      Name="NAT"
    }
}
# craeting rt
resource "aws_route_table" "name2" {
    vpc_id = aws_vpc.name.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.name.id
    }
    tags = {
      Name="pvt-rt"
    }
}
#RT subnet association
resource "aws_route_table_association" "name2" {
    subnet_id = aws_subnet.name2.id
    route_table_id = aws_route_table.name2.id
  
}