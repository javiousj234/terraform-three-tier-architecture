output "secret_arn" {
  description = "ARN of the database credentials secret"
  value       = aws_secretsmanager_secret.db.arn
}

output "db_endpoint" {
  description = "RDS database endpoint"
  value       = aws_db_instance.app.address
}

output "db_port" {
  description = "RDS database port"
  value       = aws_db_instance.app.port
}

output "db_instance_identifier" {
  value = aws_db_instance.app.identifier
}

