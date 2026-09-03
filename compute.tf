module "compute" {
  source = "./modules/compute"

  instance_type             = var.instance_type
  app_security_group_id     = module.security.app_sg_id
  iam_instance_profile_name = module.iam.instance_profile_name

  secret_arn = module.database.secret_arn
  aws_region = var.aws_region

  private_subnet_ids = module.network.private_subnet_ids
  target_group_arn   = module.load_balancer.target_group_arn

  asg_min_size         = var.asg_min_size
  asg_max_size         = var.asg_max_size
  asg_desired_capacity = var.asg_desired_capacity
  cpu_target_value     = var.cpu_target_value
}