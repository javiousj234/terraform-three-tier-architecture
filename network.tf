module "network" {
  source = "./modules/network"

  vpc_cidr = var.vpc_cidr

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

  private_subnets = {
    private_a = {
      cidr = var.private_subnet_a_cidr
      az   = var.availability_zone_a
    }

    private_b = {
      cidr = var.private_subnet_b_cidr
      az   = var.availability_zone_b
    }
  }

  db_subnets = {
    db_a = {
      cidr = var.db_subnet_a_cidr
      az   = var.availability_zone_a
    }

    db_b = {
      cidr = var.db_subnet_b_cidr
      az   = var.availability_zone_b
    }
  }


}