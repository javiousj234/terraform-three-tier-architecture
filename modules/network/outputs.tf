output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"

  value = [
    aws_subnet.public["public_a"].id,
    aws_subnet.public["public_b"].id
  ]
}

output "private_subnet_ids" {
  description = "IDs of the private application subnets"

  value = [
    aws_subnet.private["private_a"].id,
    aws_subnet.private["private_b"].id
  ]
}

output "db_subnet_ids" {
  description = "IDs of the database subnets"

  value = [
    aws_subnet.db["db_a"].id,
    aws_subnet.db["db_b"].id
  ]
}