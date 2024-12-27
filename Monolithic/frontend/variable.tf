# Generic variables
variable "region" {}

# Network variables
variable "vpc_cidr" {}
variable "public_subnet_az1_cidr" {}
variable "public_subnet_az2_cidr" {}
variable "private_subnet_az1_cidr" {}
variable "private_subnet_az2_cidr" {}

# Compute variables
variable "ami_id" {}
variable "instance_type" {}

# variable "public_subnet_ids" {}
# variable "security_groups" {}
# variable "public_subnet_ids" {}
# variable "security_groups" {}
# variable "db_sg_id" {}
# variable "db_subnet_group_name" {}
