#vpc creation
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name="custom_vpc"
  }
}
#subnets creation
resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone ="us-east-1a"
    tags = {
      Name="subnet-1-public"
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
# Internet gateway
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
      Name="IG"
    }
}
#Route table creation
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
# RT--subnet association
resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.name.id
    route_table_id = aws_route_table.name.id
  
}
# SG--cretion
resource "aws_security_group" "name" {
    vpc_id = aws_vpc.name.id
    name = "allow"     # it is mandatory
    ingress {
        description = "http"
        from_port = 80
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "Tcp"
    }
    ingress {
        description = "https"
        from_port = 443
        to_port = 443
        protocol = "Tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "Tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags= {
        Name="new"
    }
}
# creation of Ec2
resource "aws_instance" "name" {
    ami = "ami-0532be01f26a3de55"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.name.id
    vpc_security_group_ids = [ aws_security_group.name.id ]
    associate_public_ip_address = true
    tags= {
        Name="custom_ec2"
    }
}
# creating prvt ec2
resource "aws_instance" "name2" {
    ami = "ami-0532be01f26a3de55"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.name2.id
    vpc_security_group_ids = [ aws_security_group.name.id ]
    tags= {
        Name="prvt_ec2"
    } 
}
#elastic ip
resource "aws_eip" "name" {
    domain = "vpc"
}
# creating NAT gateway
resource "aws_nat_gateway" "name" {
    allocation_id = aws_eip.name.id
    subnet_id =aws_subnet.name.id
}
#create rt
resource "aws_route_table" "name2" {
    vpc_id = aws_vpc.name.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.name.id    
    }
    tags = {
      Name="pr-rt"
    }
}
# nat- subnet association
resource "aws_route_table_association" "name2" {
    subnet_id = aws_subnet.name2.id
    route_table_id = aws_route_table.name2.id
}