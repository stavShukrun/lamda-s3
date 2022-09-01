output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "private_subnets_id" {
  value = aws_subnet.private_subnet.id
}

output "default_sg_id" {
  value = aws_security_group.default.id
}