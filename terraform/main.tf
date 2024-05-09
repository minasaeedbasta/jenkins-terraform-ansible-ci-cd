module "network" {
  source         = "./network"
  region         = var.region
  vpc_cidr_block = var.vpc_cidr_block
  subnets        = var.subnets
}
