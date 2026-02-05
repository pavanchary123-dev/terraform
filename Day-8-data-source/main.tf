data "aws_subnet" "name" {
  filter {
    name = "tag:Name"
    values = [ "project-subnet-public1-us-west-2a" ]
  }
}

data "aws_subnet" "name1" {
  filter {
    name = "tag:Name"
    values = [ "project-subnet-public2-us-west-2b" ]
  }
}

resource "aws_db_subnet_group" "name" {
  name = "my_grp"
  subnet_ids = [ data.aws_subnet.name.id,data.aws_subnet.name1.id ]

}