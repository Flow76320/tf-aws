# resource "aws_security_group" "ssh_pub_ip" {
#   name_prefix = "asg"
#   vpc_id      = module.vpc.vpc_id

#   ingress {
#     from_port = 22
#     to_port   = 22
#     protocol  = "tcp"

#     cidr_blocks = [
#       # "10.0.0.0/8",  # TODO get pub IP
#     ]
#   }
# }
