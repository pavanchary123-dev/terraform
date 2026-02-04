module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type = "t3.micro"
  key_name      = ""
  monitoring    = true
  subnet_id     = "subnet-00e43806c321d689a"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}