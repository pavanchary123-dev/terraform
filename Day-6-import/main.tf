resource "aws_instance" "name" {
  ami = "ami-0532be01f26a3de55"
  instance_type="t3.micro"
  tags = {
    Name="ec2"
  }
}
resource "aws_s3_bucket" "name" {
  bucket = "gdhhhhhfhfh"

}
# to import remote/current state manual configurations to the working directory
# here frst we need to define empty resource block then use import cmd
# terraform import aws_instance.name <instance id>
# terraform import aws_s3_bucket.name <s3 name>
# or any other resources same process