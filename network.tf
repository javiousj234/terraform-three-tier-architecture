# ============================================================
# VPC
# ============================================================

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "terraform-learning-vpc"
  }
}


# ============================================================
# PUBLIC SUBNETS
# ============================================================

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = var.availability_zone_a
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-public-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = var.availability_zone_b
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-public-b"
  }
}


# ============================================================
# PRIVATE APPLICATION SUBNETS
# ============================================================

resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_a_cidr
  availability_zone       = var.availability_zone_a
  map_public_ip_on_launch = false

  tags = {
    Name = "terraform-private-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_b_cidr
  availability_zone       = var.availability_zone_b
  map_public_ip_on_launch = false

  tags = {
    Name = "terraform-private-b"
  }
}


# ============================================================
# PRIVATE DATABASE SUBNETS
# ============================================================

resource "aws_subnet" "db_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.41.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "terraform-db-a"
  }
}

resource "aws_subnet" "db_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.51.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "terraform-db-b"
  }
}


# ============================================================
# INTERNET GATEWAY
# ============================================================

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "terraform-learning-igw"
  }
}


# ============================================================
# NAT GATEWAY
# ============================================================

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "terraform-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_a.id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "terraform-nat-gateway"
  }
}


# ============================================================
# PUBLIC ROUTING
# ============================================================

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "terraform-public-rt"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}


# ============================================================
# PRIVATE ROUTING
# ============================================================

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "terraform-private-rt"
  }
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}