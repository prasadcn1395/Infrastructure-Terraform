# Development Environment Outputs

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = module.vpc.public_subnet_id
}

output "security_group_id" {
  description = "Security group ID"
  value       = module.security_group.security_group_id
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2.instance_id
}

output "instance_public_ip" {
  description = "EC2 instance public IP"
  value       = module.ec2.instance_public_ip
}

output "instance_private_ip" {
  description = "EC2 instance private IP"
  value       = module.ec2.instance_private_ip
}
