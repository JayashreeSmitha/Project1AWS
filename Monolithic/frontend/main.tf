module "network" {
  source = "../modules/network"
  vpc_cidr = var.vpc_cidr
  public_subnet_az1_cidr = var.public_subnet_az1_cidr
  public_subnet_az2_cidr = var.public_subnet_az2_cidr
  private_subnet_az1_cidr = var.private_subnet_az1_cidr
  private_subnet_az2_cidr = var.private_subnet_az2_cidr
  region = var.region
}

 module "compute" {
   source = "../modules/compute"
   ami_id = var.ami_id
   instance_type = var.instance_type
 }

# module "alb" {
#   source = "../modules/alb"
#   region = var.region
#   vpc_id = module.network.vpc_id
#   public_subnet_ids = [module.network.public_subnet_az1_id, module.network.public_subnet_az2_id]
# }
