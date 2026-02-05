resource "aws_db_instance" "name" {
  db_name                        = "pavan"
  identifier                     = "testing"
  instance_class                 = "db.t3.micro"
  engine                         = "mysql"
  engine_version                 = "8.0"
  allocated_storage              = 10
  username                       = "admin"
  manage_master_user_password    = true  #it enable secreate manager to create credentials
  db_subnet_group_name           = aws_db_subnet_group.name.id
  parameter_group_name           = "default.mysql8.0"

  # Enable backups and retention
  backup_retention_period  = 7   # Retain backups for 7 days
  backup_window            = "02:00-03:00" # Daily backup window (UTC)

   # Maintenance window
  maintenance_window = "sun:04:00-sun:05:00"  # Maintenance every Sunday (UTC)

   # Skip final snapshot
  skip_final_snapshot = true

}

################# with data source ################

data "aws_subnet" "subnet_1" {
    filter {
      name ="tag:Name"
      values = [ "project-subnet-public1-us-west-2a"]
    }
}
data "aws_subnet" "subnet_2" {
    filter {
      name = "tag:Name"
      values = [ "project-subnet-public2-us-west-2b" ]
    }
}
resource "aws_db_subnet_group" "name" {
    name = "my_grp"
    subnet_ids = [ data.aws_subnet.subnet_1.id,data.aws_subnet.subnet_2.id ]
    tags = {
      Name="my db group"
    }
}