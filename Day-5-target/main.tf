resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name ="dev_vpc"
    }
  
}
resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    tags = {
      Name ="tf_subnet"
    }
  
}
resource "aws_subnet" "name1" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name ="tf_subnet2"
    }
  
}


#we can able to apply specific resource from group of resources
#terraform plan -target=aws_vpc.name & terraform apply -target=aws_vpc.name & terraform destroy -target=aws_vpc.name

# we can use this -target in same cmd with multiple resources
#terraform plan -target=aws_vpc.name -target=aws_subnet.name
#terraform apply -target=aws_vpc.name -target=aws_subnet.name
#terraform destroy -target=aws_vpc.name -target=aws_subnet.name