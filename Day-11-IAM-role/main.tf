############ IAM role creation ###############

resource "aws_iam_role" "ec2-role" {
  name ="ec2-admin"
  assume_role_policy =jsonencode(
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]
}
  )
}

############ Policy is attaching to the role #################

resource "aws_iam_role_policy_attachment" "name" {
    role =aws_iam_role.ec2-role.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

############# Create instance profile ,so it can be attached to instance #########

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2-role.name
  depends_on = [ aws_iam_role.ec2-role ]
}

############### So, here we can able to attach the role to our instance ###########

resource "aws_instance" "name" {
  ami = "ami-0c1fe732b5494dc14"
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  tags = {
   Name="pavan" 
  }
}