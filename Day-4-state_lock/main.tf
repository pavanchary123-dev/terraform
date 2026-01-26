resource "aws_vpc" "name" {
  cidr_block = var.cidr_block
  tags = {
    Name="vpc_statelock-window"
  }
}
resource "aws_s3_bucket" "name" {
  bucket =var.aws_s3_bucket
}