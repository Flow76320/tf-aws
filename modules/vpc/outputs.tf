output "vpc_arn" {
  value       = aws_vpc.vpc.arn
  description = "VPN ARN"
}

output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "VPN ID"
}
