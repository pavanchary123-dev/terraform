resource "aws_instance" "name" {
  instance_type = "t2.micro"
  ami = "ami-055a9df0c8c9f681c"
  depends_on = [ aws_s3_bucket.name ]
}

resource "aws_s3_bucket" "name" {
  bucket = "yyyyyrrrrrryyyy"
}