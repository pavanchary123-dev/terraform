terraform {
  backend "s3" {
    bucket = "state_lock"
    key = "terraform.tfstate"
    region = "eu-north"
  }
}