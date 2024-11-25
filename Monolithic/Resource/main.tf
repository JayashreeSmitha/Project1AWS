module "network" {
  source = "./modules/network"
  vpc_cidr = var.vpc_cidr
  public_subnet_az1_cidr = var.public_subnet_az1_cidr
  public_subnet_az2_cidr = var.public_subnet_az2_cidr
  private_subnet_az1_cidr = var.private_subnet_az1_cidr
  private_subnet_az2_cidr = var.private_subnet_az2_cidr
  region = var.region
}

module "compute" {
  source = "./modules/compute"
  region = var.region
  vpc_id = module.network.vpc_id
  private_subnet_ids = [module.network.private_subnet_az1_id, module.network.private_subnet_az2_id]
}

module "database" {
  source = "./modules/database"
  region = var.region
  vpc_id = module.network.vpc_id
}

module "alb" {
  source = "./modules/alb"
  region = var.region
  vpc_id = module.network.vpc_id
  public_subnet_ids = [module.network.public_subnet_az1_id, module.network.public_subnet_az2_id]
}
