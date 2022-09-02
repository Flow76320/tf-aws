resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.instance_tenancy

  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = local.tags
}

resource "aws_internet_gateway" "vpc_internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = local.tags
}

resource "aws_route_table" "vpc_default_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_internet_gateway.id
  }
}
