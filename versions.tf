# ============================================================
# TERRAFORM / PROVIDER CONFIGURATION
# ============================================================

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }

    random = {
      source = "hashicorp/random"
    }
  }

  backend "s3" {
    bucket       = "jvs-s3-tst-bucket"
    key          = "three-tier-app/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}