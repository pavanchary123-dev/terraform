module "name" {
    source ="../Day-7-modules"
     ami_id=var.ami_id
     instance_type =var.instance_type
     Name =var.Name
}