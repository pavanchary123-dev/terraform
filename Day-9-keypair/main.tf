# Key Pair
resource "aws_key_pair" "example" {
  key_name   = "pavan"
  public_key = file("~/.ssh/id_ed25519.pub")
#   public_key = file("~/.ssh/id_ed25519.pub")
}


resource "aws_instance" "server" {
  ami                         = "ami-0532be01f26a3de55" # Ubuntu AMI
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.example.key_name
  
}