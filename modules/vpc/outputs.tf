output "vpc_arn" {
  value       = aws_vpc.vpc.arn
  description = "VPN ARN"
}

output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "VPC ID"
}

output "vpc_default_route_table_id" {
  value       = aws_route_table.vpc_default_route_table.id
  description = "Default route table ID"
}
