module "load_balancer" {
  source = "./modules/load_balancer"

  project_name          = local.project_name
  alb_security_group_id = module.security.alb_sg_id
  public_subnet_ids     = module.network.public_subnet_ids
  vpc_id                = module.network.vpc_id
}