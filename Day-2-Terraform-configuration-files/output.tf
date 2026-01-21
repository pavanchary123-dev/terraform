output "public_ip" {
    value =aws_instance.name.public_ip
  
}
output "az" {
  value = aws_instance.name.availability_zone
}
output "private-ip" {
  value = aws_instance.name.private_ip
}
output "vpc_id" {
  value = aws_vpc.name.id
}