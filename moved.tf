moved {
  from = aws_eip.nat
  to   = module.network.aws_eip.nat
}

moved {
  from = aws_internet_gateway.igw
  to   = module.network.aws_internet_gateway.igw
}

moved {
  from = aws_nat_gateway.nat
  to   = module.network.aws_nat_gateway.nat
}

moved {
  from = aws_route_table.private
  to   = module.network.aws_route_table.private
}

moved {
  from = aws_route_table.public
  to   = module.network.aws_route_table.public
}

moved {
  from = aws_route_table_association.private_a
  to   = module.network.aws_route_table_association.private_a
}

moved {
  from = aws_route_table_association.private_b
  to   = module.network.aws_route_table_association.private_b
}

moved {
  from = aws_route_table_association.public_a
  to   = module.network.aws_route_table_association.public_a
}

moved {
  from = aws_route_table_association.public_b
  to   = module.network.aws_route_table_association.public_b
}

moved {
  from = aws_subnet.db_a
  to   = module.network.aws_subnet.db_a
}

moved {
  from = aws_subnet.db_b
  to   = module.network.aws_subnet.db_b
}

moved {
  from = aws_subnet.private_a
  to   = module.network.aws_subnet.private_a
}

moved {
  from = aws_subnet.private_b
  to   = module.network.aws_subnet.private_b
}

moved {
  from = aws_subnet.public_a
  to   = module.network.aws_subnet.public_a
}

moved {
  from = aws_subnet.public_b
  to   = module.network.aws_subnet.public_b
}

moved {
  from = aws_vpc.main
  to   = module.network.aws_vpc.main
}

moved {
  from = module.network.aws_subnet.public_a
  to   = module.network.aws_subnet.public["public_a"]
}

moved {
  from = module.network.aws_subnet.public_b
  to   = module.network.aws_subnet.public["public_b"]
}

moved {
  from = module.network.aws_subnet.private_a
  to   = module.network.aws_subnet.private["private_a"]
}

moved {
  from = module.network.aws_subnet.private_b
  to   = module.network.aws_subnet.private["private_b"]
}

moved {
  from = module.network.aws_subnet.db_a
  to   = module.network.aws_subnet.db["db_a"]
}

moved {
  from = module.network.aws_subnet.db_b
  to   = module.network.aws_subnet.db["db_b"]
}

moved {
  from = module.network.aws_route_table_association.public_a
  to   = module.network.aws_route_table_association.public["public_a"]
}

moved {
  from = module.network.aws_route_table_association.public_b
  to   = module.network.aws_route_table_association.public["public_b"]
}

moved {
  from = module.network.aws_route_table_association.private_a
  to   = module.network.aws_route_table_association.private["private_a"]
}

moved {
  from = module.network.aws_route_table_association.private_b
  to   = module.network.aws_route_table_association.private["private_b"]
}

moved {
  from = aws_security_group.alb
  to   = module.security.aws_security_group.alb
}

moved {
  from = aws_security_group.app
  to   = module.security.aws_security_group.app
}

moved {
  from = aws_security_group.db
  to   = module.security.aws_security_group.db
}

moved {
  from = aws_db_subnet_group.app
  to   = module.database.aws_db_subnet_group.app
}

moved {
  from = random_password.db
  to   = module.database.random_password.db
}

moved {
  from = aws_db_instance.app
  to   = module.database.aws_db_instance.app
}

moved {
  from = aws_secretsmanager_secret.db
  to   = module.database.aws_secretsmanager_secret.db
}

moved {
  from = aws_secretsmanager_secret_version.db
  to   = module.database.aws_secretsmanager_secret_version.db
}

moved {
  from = aws_launch_template.app
  to   = module.compute.aws_launch_template.app
}

moved {
  from = aws_autoscaling_group.app
  to   = module.compute.aws_autoscaling_group.app
}

moved {
  from = aws_autoscaling_policy.cpu_target
  to   = module.compute.aws_autoscaling_policy.cpu_target
}

moved {
  from = aws_iam_role.app
  to   = module.iam.aws_iam_role.app
}

moved {
  from = aws_iam_role_policy.app_secret_access
  to   = module.iam.aws_iam_role_policy.app_secret_access
}

moved {
  from = aws_iam_instance_profile.app
  to   = module.iam.aws_iam_instance_profile.app
}

moved {
  from = aws_lb.app
  to   = module.load_balancer.aws_lb.app
}

moved {
  from = aws_lb_target_group.app
  to   = module.load_balancer.aws_lb_target_group.app
}

moved {
  from = aws_lb_listener.http
  to   = module.load_balancer.aws_lb_listener.http
}