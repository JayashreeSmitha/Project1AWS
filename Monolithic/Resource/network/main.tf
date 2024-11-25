resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public_az1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_az1_cidr
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-az1" }
}

resource "aws_subnet" "public_az2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_az2_cidr
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-az2" }
}

resource "aws_subnet" "private_az1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_az1_cidr
  availability_zone = "us-east-2a"
  tags = { Name = "private-subnet-az1" }
}

resource "aws_subnet" "private_az2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_az2_cidr
  availability_zone = "us-east-2b"
  tags = { Name = "private-subnet-az2" }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = { Name = "main-igw" }
}

resource "aws_nat_gateway" "nat_az1" {
  allocation_id = aws_eip.nat_az1.id
  subnet_id = aws_subnet.public_az1.id
  tags = { Name = "nat-gateway-az1" }
}

resource "aws_eip" "nat_az1" {
  vpc = true
  tags = { Name = "nat-eip-az1" }
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet_az1_id" {
  value = aws_subnet.private_az1.id
}

output "private_subnet_az2_id" {
  value = aws_subnet.private_az2.id
}

output "public_subnet_az1_id" {
  value = aws_subnet.public_az1.id
}

output "public_subnet_az2_id" {
  value = aws_subnet.public_az2.id
}
