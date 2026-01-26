terraform {
  backend "s3" {
    bucket = "state-lock-p"
    key = "terraform.tfstate"
    #use_lockfile = true #it enables S3-state locking
    dynamodb_table ="pavan"
    encrypt = true
    region = "eu-north-1"
  }
}