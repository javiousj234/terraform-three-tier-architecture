locals {
  project_name = "terraform-app"

  common_tags = {
    Project   = local.project_name
    ManagedBy = "Terraform"
  }
}