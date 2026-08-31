# ============================================================
# OUTPUTS
# ============================================================

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.app.dns_name
}

output "db_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = aws_db_instance.app.address
}

output "db_port" {
  description = "RDS PostgreSQL port"
  value       = aws_db_instance.app.port
}