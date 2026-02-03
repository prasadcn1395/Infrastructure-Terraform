# VPC Module - Outputs

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = aws_subnet.public.id
}

output "public_subnet_cidr" {
  description = "Public subnet CIDR block"
  value       = aws_subnet.public.cidr_block
}

output "private_subnet_id" {
  description = "Private subnet ID"
  value       = try(aws_subnet.private[0].id, null)
}

output "private_subnet_cidr" {
  description = "Private subnet CIDR block"
  value       = try(aws_subnet.private[0].cidr_block, null)
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.main.id
}

output "public_route_table_id" {
  description = "Public route table ID"
  value       = aws_route_table.public.id
}
