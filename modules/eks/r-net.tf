# 2 subnets with Internet access to get HA
resource "aws_subnet" "eks_subnet_primary" {
  vpc_id            = var.eks_vpc_id
  cidr_block        = var.eks_cidr_block_primary
  availability_zone = data.aws_availability_zones.available.names[0]

  map_public_ip_on_launch = true # TODO This assigns public IP for all nodes. Can be improved

  tags = local.tags
}

resource "aws_subnet" "eks_subnet_secondary" {
  vpc_id            = var.eks_vpc_id
  cidr_block        = var.eks_cidr_block_secondary
  availability_zone = data.aws_availability_zones.available.names[1]

  map_public_ip_on_launch = true # TODO This assigns public IP for all nodes. Can be improved

  tags = local.tags
}

resource "aws_route_table_association" "vpc_default_route_table_association_primary" {
  subnet_id      = aws_subnet.eks_subnet_primary.id
  route_table_id = var.vpc_default_route_table_id
}

resource "aws_route_table_association" "vpc_default_route_table_association_secondary" {
  subnet_id      = aws_subnet.eks_subnet_secondary.id
  route_table_id = var.vpc_default_route_table_id
}

# Default cluster network security rules
resource "aws_security_group" "eks_sg" {
  name        = local.eks_sg
  description = "Cluster communication with worker nodes"
  vpc_id      = var.eks_vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}

resource "aws_security_group_rule" "eks_sg_rule_api" {
  cidr_blocks       = [local.my_public_ip_cidr]
  description       = "Allow Terraform to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_sg.id
  to_port           = 443
  type              = "ingress"
}

