variable "aws_region" {
  description = "AWS region for all resources"
  type        = string

}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string

}

variable "public_subnet_a_cidr" {
  description = "CIDR block for public subnet A"
  type        = string

}

variable "public_subnet_b_cidr" {
  description = "CIDR block for public subnet B"
  type        = string

}

variable "private_subnet_a_cidr" {
  description = "CIDR block for private application subnet A"
  type        = string
}

variable "private_subnet_b_cidr" {
  description = "CIDR block for private application subnet B"
  type        = string

}

variable "db_subnet_a_cidr" {
  description = "CIDR block for database subnet A"
  type        = string

}

variable "db_subnet_b_cidr" {
  description = "CIDR block for database subnet B"
  type        = string

}

variable "availability_zone_a" {
  description = "First availability zone"
  type        = string

}

variable "availability_zone_b" {
  description = "Second availability zone"
  type        = string

}

variable "instance_type" {
  description = "EC2 instance type for application servers"
  type        = string

}

variable "asg_min_size" {
  description = "Minimum number of EC2 instances"
  type        = number

}

variable "asg_max_size" {
  description = "Maximum number of EC2 instances"
  type        = number

}

variable "asg_desired_capacity" {
  description = "Desired number of EC2 instances"
  type        = number

}

variable "cpu_target_value" {
  description = "Target average CPU utilization for Auto Scaling"
  type        = number

}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string

}

variable "db_allocated_storage" {
  description = "Initial RDS storage in GB"
  type        = number

}