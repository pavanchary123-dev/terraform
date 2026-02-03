resource "aws_instance" "name" {
    ami = "ami-0532be01f26a3de55"
    instance_type = "t2.micro"
    tags = {
      Name="new"
    }
    # IT ignores any changes at the remote end/console level
    #and here i defined two lifecycle rules terraform won't allow two lifecycle rules at a time
    lifecycle {         
      ignore_changes = [ tags ]
    }
  #  lifecycle {
   #   prevent_destroy = true
   # }
}
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
#it prevent resource from destroy
#    lifecycle {
 #     prevent_destroy = true
  #  }
}
resource "aws_s3_bucket" "name" {
  bucket = "qwertyuiopc"
  #It acts opposite the default behaviour it frst creates the s3 then destroy
  #here i changed the s3 name and it frst destory the old s3 and creates the new s3 with new name
  lifecycle {
    create_before_destroy = true
  }
}

