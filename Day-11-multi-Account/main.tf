resource "aws_instance" "name" {
  ami="ami-0c1fe732b5494dc14" 
  instance_type = "t2.micro"
  tags = {
    Name="pavan"
  }
  
}

resource "aws_s3_bucket" "name" {
    bucket = "tybuwbdsjbcscj"
    provider = aws.oregon
    
}