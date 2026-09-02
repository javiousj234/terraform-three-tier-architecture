module "network" {
  source = "./modules/network"

  vpc_cidr = var.vpc_cidr

  public_subnet_a_cidr = var.public_subnet_a_cidr
  public_subnet_b_cidr = var.public_subnet_b_cidr

  public_subnets = {
    public_a = {
      cidr = var.public_subnet_a_cidr
      az   = var.availability_zone_a
    }

    public_b = {
      cidr = var.public_subnet_b_cidr
      az   = var.availability_zone_b
    }
  }
  private_subnet_a_cidr = var.private_subnet_a_cidr
  private_subnet_b_cidr = var.private_subnet_b_cidr

  db_subnet_a_cidr = var.db_subnet_a_cidr
  db_subnet_b_cidr = var.db_subnet_b_cidr

  availability_zone_a = var.availability_zone_a
  availability_zone_b = var.availability_zone_b
}