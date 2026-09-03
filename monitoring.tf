module "monitoring" {
  source = "./modules/monitoring"

  db_instance_identifier = module.database.db_instance_identifier
  alert_email            = var.alert_email
}