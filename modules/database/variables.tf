variable "db_subnet_ids" {
  description = "Subnet IDs for the RDS DB subnet group"
  type        = list(string)
}

variable "db_security_group_id" {
  description = "Security group ID for RDS"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "db_allocated_storage" {
  description = "Allocated storage for RDS"
  type        = number
}