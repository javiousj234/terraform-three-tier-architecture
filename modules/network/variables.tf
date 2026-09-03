variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}


variable "public_subnets" {
  description = "Configuration for public subnets"

  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  description = "Configuration for private application subnets"

  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "db_subnets" {
  description = "Configuration for database subnets"

  type = map(object({
    cidr = string
    az   = string
  }))
}