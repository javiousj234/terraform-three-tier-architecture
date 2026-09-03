variable "instance_type" {
  description = "EC2 instance type used by the application"
  type        = string
}

variable "app_security_group_id" {
  description = "Security group ID for application instances"
  type        = string
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile attached to EC2 instances"
  type        = string
}

variable "secret_arn" {
  description = "ARN of the database credentials secret"
  type        = string
}

variable "aws_region" {
  description = "AWS region used by the application"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs used by the Auto Scaling Group"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ALB target group ARN"
  type        = string
}

variable "asg_min_size" {
  description = "Minimum ASG capacity"
  type        = number
}

variable "asg_max_size" {
  description = "Maximum ASG capacity"
  type        = number
}

variable "asg_desired_capacity" {
  description = "Desired ASG capacity"
  type        = number
}

variable "cpu_target_value" {
  description = "Target average CPU utilization for Auto Scaling"
  type        = number
}