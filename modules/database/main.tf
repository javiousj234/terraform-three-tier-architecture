# ============================================================
# RDS SUBNET GROUP
# ============================================================

resource "aws_db_subnet_group" "app" {
  name       = "terraform-app-db-subnets"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "terraform-app-db-subnets"
  }
}

# ============================================================
# RANDOM DATABASE PASSWORD
# ============================================================

resource "random_password" "db" {
  length  = 24
  special = true
}



# ============================================================
# SECRETS MANAGER
# ============================================================

resource "aws_secretsmanager_secret" "db" {
  name = "terraform-app-db-credentials"

  tags = {
    Name = "terraform-app-db-credentials"
  }
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id

  secret_string = jsonencode({
    username = aws_db_instance.app.username
    password = random_password.db.result
    host     = aws_db_instance.app.address
    port     = aws_db_instance.app.port
    dbname   = aws_db_instance.app.db_name
  })
}

#=========================================
# PostgreSQL db
# =========================================
resource "aws_db_instance" "app" {
  identifier = "terraform-app-db"

  engine         = "postgres"
  engine_version = "17"

  instance_class        = var.db_instance_class
  allocated_storage     = var.db_allocated_storage
  max_allocated_storage = 100
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = "appdb"
  username = "appadmin"
  password = random_password.db.result
  port     = 5432


  db_subnet_group_name = aws_db_subnet_group.app.name

  vpc_security_group_ids = [
    var.db_security_group_id
  ]

  publicly_accessible     = false
  multi_az                = false
  backup_retention_period = 1
  skip_final_snapshot     = true
  deletion_protection     = false

  tags = {
    Name = "terraform-app-db"
  }
}