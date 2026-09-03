variable "db_instance_identifier" {
  description = "RDS instance identifier monitored by CloudWatch"
  type        = string
}

variable "alert_email" {
  description = "Email address subscribed to infrastructure alerts"
  type        = string
}