variable "vpc_cidr" {
  description = "CIDR block of the vpc"
}

variable "public_subnet_cidr" {
  description = "CIDR block for Public Subnet"
}

variable "private_subnet_cidr" {
  description = "CIDR block for Private Subnet"
}

variable "region" {
  description = "Region"
}

variable "availability_zone" {
  description = "AZ in which all the resources will be deployed"
}