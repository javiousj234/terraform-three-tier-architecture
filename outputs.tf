# ============================================================
# OUTPUTS
# ============================================================

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.load_balancer.alb_dns_name
}

output "db_endpoint" {
  description = "RDS database endpoint"
  value       = module.database.db_endpoint
}

output "db_port" {
  description = "RDS database port"
  value       = module.database.db_port
}