resource "aws_vpc" "name" {
  cidr_block = var.cidr_block
  tags = {
    Name="vpc_statelock-linux"
  }
}
resource "aws_s3_bucket" "name" {
  bucket =var.aws_s3_bucket
}
resource "aws_instance" "name" {
  ami = var.ami
  instance_type=var.instance_type
  subnet_id = aws_subnet.name.id
  tags = {
    Name="pavan"
  }
}
resource "aws_subnet" "name" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name="mee too"
  }
}