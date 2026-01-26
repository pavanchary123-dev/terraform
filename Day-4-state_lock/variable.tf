variable "aws_s3_bucket" {
  description = "s3_bucket"
  default = "state-lock-p"
}
variable "cidr_block" {
  default = "10.0.0.0/16"
}