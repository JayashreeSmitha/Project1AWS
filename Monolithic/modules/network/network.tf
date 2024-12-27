# VPC creation
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

# Public Subnet 1
resource "aws_subnet" "public_az1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_az1_cidr
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-az1" }
}

# Public Subnet 2
resource "aws_subnet" "public_az2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_az2_cidr
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-az2" }
}

# Private Subnet 1
resource "aws_subnet" "private_az1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_az1_cidr
  availability_zone = "us-east-2a"
  tags = { Name = "private-subnet-az1" }
}

# Private Subnet 2
resource "aws_subnet" "private_az2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_az2_cidr
  availability_zone = "us-east-2b"
  tags = { Name = "private-subnet-az2" }
}

# IGW
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = { Name = "main-igw" }
}

# NAT gateway
resource "aws_nat_gateway" "nat_az1" {
  connectivity_type = "public"
  allocation_id = aws_eip.nat_az1.id
  subnet_id = aws_subnet.public_az1.id
  tags = { Name = "nat-gateway-az1" }
}

# EIP
resource "aws_eip" "nat_az1" {
  tags = { Name = "nat-eip-az1" }
}

# route table for public subnets
resource "aws_route_table" "public_subnet_route" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = { Name      = "public-route-table"}
}

# associate public subnet 1 with public routing table
resource "aws_route_table_association" "public_route_subnet_merge_1" {
  subnet_id      = aws_subnet.public_az1.id
  route_table_id = aws_route_table.public_subnet_route.id
}

# associate public subnet 2 with public routing table
resource "aws_route_table_association" "public_route_subnet_merge_2" {
  subnet_id      = aws_subnet.public_az2.id
  route_table_id = aws_route_table.public_subnet_route.id
}

# route table for private subnets
resource "aws_route_table" "private_subnet_route" {
  vpc_id         = aws_vpc.main.id
  route           {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_az1.id
  }
}

# associate private subnet 1 with private routing table
resource "aws_route_table_association" "private_route_subnet_merge_1" {
  subnet_id      = aws_subnet.private_az1.id
  route_table_id = aws_route_table.private_subnet_route.id
}

# associate private subnet 2 with private routing table
resource "aws_route_table_association" "private_route_subnet_merge_2" {
  subnet_id      = aws_subnet.private_az2.id
  route_table_id = aws_route_table.private_subnet_route.id
}

# Outputs
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
