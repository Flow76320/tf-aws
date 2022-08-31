resource "aws_subnet" "eks_subnet_primary" {
  vpc_id            = var.eks_vpc_id
  cidr_block        = var.eks_cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = local.tags
}

resource "aws_subnet" "eks_subnet_secondary" {
  vpc_id            = var.eks_vpc_id
  cidr_block        = var.eks_cidr_block
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = local.tags
}

#TODO ASG
# resource "aws_security_group" "ssh_pub_ip" {
#   name_prefix = "asg"
#   vpc_id      = var.eks_vpc_id

#   ingress {
#     from_port = 22
#     to_port   = 22
#     protocol  = "tcp"

#     cidr_blocks = [
#       # "10.0.0.0/8",  # TODO get pub IP
#     ]
#   }
# }
