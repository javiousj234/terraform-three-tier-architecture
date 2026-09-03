module "database" {
  source = "./modules/database"

  db_subnet_ids        = module.network.db_subnet_ids
  db_security_group_id = module.security.db_sg_id

  db_instance_class    = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
}