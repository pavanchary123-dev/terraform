resource "aws_security_group" "my_cust_rules" {
  name = "my-sg-rule"
  description = "allow TLS inbouond traffic"
  # vpc_id if mentioned sg will create to that vpc
  # vpc_id = "paste here vpc-id"
  ingress = [ 
    for port in [22,443,80,3306,11434,6479,5000] : {
        description      = "inbound rule"
        from_port        = port
        to_port          = port
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids  = []
        security_groups  = []
        self             = false
    }
   ]
   egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks =["0.0.0.0/0"]
   }
tags = {
    Name="my-sg-rules"
}

}