module "security" {
  source = "./modules/security"

  vpc_id = module.network.vpc_id
}