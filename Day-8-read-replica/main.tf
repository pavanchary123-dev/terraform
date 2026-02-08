resource "aws_db_instance" "name" {
    db_name                     = "pavan"
    username                    = "admin"
    password                    = "pavan123"
    instance_class              = "db.t3.micro"
    allocated_storage           = 10
    identifier                  = "rds-new"
    backup_retention_period     = 7
    backup_window               = "02:00-03:00"
    engine                      = "mysql"
    engine_version              = "8.0"
    parameter_group_name        = "default.mysql8.0"
    db_subnet_group_name        =aws_db_subnet_group.name.id
    maintenance_window          = "sun:04:00-sun:05:00"
    skip_final_snapshot         = true
    deletion_protection         = false
}

resource "aws_db_subnet_group" "name" {
    name                        = "subnet_group"
    subnet_ids                  = [ "subnet-0d3ae350c454e0091","subnet-0ce913947256ccd5e" ]
    tags = {
      Name="subnetss"
    }
  
}
########### Replica creation###################
resource "aws_db_instance" "replica" {
    identifier                = "replica"
    instance_class            = "db.t3.micro"
    skip_final_snapshot       = true
    backup_retention_period   = 7
    replicate_source_db       =aws_db_instance.name.identifier
}
output "replica_url" {
  value = aws_db_instance.replica.endpoint
}
resource "aws_db_instance" "namee" {
    identifier               = "replica-2"
    instance_class           = "db.t3.micro"
    replicate_source_db      = aws_db_instance.name.identifier
    # replicate_source_db = aws_db_instance.name.arn ---> we can use this if we mention subnet group
    #and also to crete replica in cross region.
}
############ Note ################
# here we can use secreate manager when generating replica but we selected mysql engine so it was not
# allowing , we need to use self managed passward for this if we want to use secreate manager we need 
# to use AURORA-MYSQL  but we need to chane all configurations  