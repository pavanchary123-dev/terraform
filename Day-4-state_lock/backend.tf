terraform {
  backend "s3" {
    bucket = "state-lock-p"
    key = "terraform.tfstate"
    use_lockfile = true #it enables S3-state locking
    region = "eu-north-1"
  }
}