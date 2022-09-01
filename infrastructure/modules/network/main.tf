# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "example-vpc"
    Environment = "example"
  }
}

# Subnets
# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "example-igw"
    Environment = "example"
  }
}

# Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone[0]
  map_public_ip_on_launch = true

  tags = {
    Name        = "example-public-subnet"
    Environment = "example"
  }
}


# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = var.availability_zone[0]
  map_public_ip_on_launch = false

  tags = {
    Name        = "example-private-subnet"
    Environment = "example"
  }
}

# Default Security Group of VPC
resource "aws_security_group" "default" {
  name        = "example-default-sg"
  description = "Default SG to allow traffic from the VPC"
  vpc_id      = aws_vpc.vpc.id
  depends_on = [
    aws_vpc.vpc
  ]

    ingress {
    from_port = "443"
    to_port   = "443"
    protocol  = "TCP"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }

  tags = {
    Environment = "example"
  }
}