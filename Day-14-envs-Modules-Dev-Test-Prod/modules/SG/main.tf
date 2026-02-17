resource "aws_security_group" "name" {
  description = "Allow SSH and HTTP"
    vpc_id      = var.vpc_id
    
    ingress = [
        for port in [22, 80, 443,3306] : {
            description= "Allow traffic on port ${port}"
             from_port   = port
             to_port     = port
             protocol    = "tcp"
             cidr_blocks = ["0.0.0.0/0"]
             ipv6_cidr_blocks = []
             prefix_list_ids  = []
             security_groups  = []
             self             = false  
        }
    ]
    
    egress = [
        {
            description = "Allow all outbound traffic"
             from_port   = 0
             to_port     = 0
             protocol    = "-1"
             cidr_blocks = ["0.0.0.0/0"]
             ipv6_cidr_blocks = []
             prefix_list_ids  = []
             security_groups  = []
             self             = false  
   }
    ]   
    tags = {
        Name = "sg-${var.env}"
    }
}