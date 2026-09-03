module "iam" {
  source = "./modules/iam"

  secret_arn = module.database.secret_arn
}