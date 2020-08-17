provider "aws" {
  region = var.region
}

data "aws_availability_zones" "dev_zones_available" {}

# Creating the VPC

resource "aws_vpc" "dev_main_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev_main_vpc"
  }
}

# Creating Internet Gateway

resource "aws_internet_gateway" "dev_main_internet_gateway" {
  # Attaching to my vpc
  vpc_id = aws_vpc.dev_main_vpc.id

  tags = {
    Name = "dev_main_internet_gateway"
  }
}

# Creating a public Route Table

resource "aws_route_table" "dev_public_route_table" {
  vpc_id = aws_vpc.dev_main_vpc.id

  route {
    cidr_block = var.public_cidr_rt
    gateway_id = aws_internet_gateway.dev_main_internet_gateway.id
  }

  tags = {
    Name = "dev_public_route_table"
  }
}

# Creating a private Route Table

resource "aws_default_route_table" "dev_private_route_table" {
  default_route_table_id = aws_vpc.dev_main_vpc.default_route_table_id

  tags = {
    Name = "dev_private_route_table"
  }
}

# Creating the public subnets

resource "aws_subnet" "dev_public_subnet" {
  count  = 2
  vpc_id = aws_vpc.dev_main_vpc.id
  #cidr_block = "10.0.1.0/24"
  cidr_block              = var.public_cidrs_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.dev_zones_available.names[count.index]

  tags = {
    Name = "dev_public_subnet-${count.index + 1}"
  }
}

# Creating the private subnets

resource "aws_subnet" "dev_private_subnet" {
  count  = 2
  vpc_id = aws_vpc.dev_main_vpc.id
  #cidr_block = "10.0.1.0/24"
  cidr_block              = var.private_cidrs_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.dev_zones_available.names[count.index]

  tags = {
    Name = "dev_private_subnet-${count.index + 1}"
  }
}

# AWS public Route table association

resource "aws_route_table_association" "dev_public_subnet_association" {
  count          = 2
  route_table_id = aws_route_table.dev_public_route_table.id
  subnet_id      = aws_subnet.dev_public_subnet.*.id[count.index]
  depends_on     = [aws_route_table.dev_public_route_table, aws_subnet.dev_public_subnet]
}

# AWS private Route table association

resource "aws_route_table_association" "dev_private_subnet_association" {
  count          = 2
  route_table_id = aws_default_route_table.dev_private_route_table.id
  subnet_id      = aws_subnet.dev_private_subnet.*.id[count.index]
  depends_on     = [aws_default_route_table.dev_private_route_table, aws_subnet.dev_private_subnet]
}

resource "aws_security_group" "dev-security-group" {
  name        = "dev-security-group"
  description = "Allow public trafic"
  vpc_id      = aws_vpc.dev_main_vpc.id

  # New version with foreach
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "dev-security-group "
  }
}