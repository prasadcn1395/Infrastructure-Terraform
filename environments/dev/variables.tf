# Development Environment Variables

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "myproject"
}

# VPC Variables
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "Private subnet CIDR block"
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "Availability zone"
  type        = string
  default     = "us-east-1a"
}

variable "create_private_subnet" {
  description = "Create private subnet"
  type        = bool
  default     = false
}

# Security Group Variables
variable "enable_ssh" {
  description = "Enable SSH access"
  type        = bool
  default     = true
}

variable "ssh_cidrs" {
  description = "SSH CIDR blocks"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# EC2 Variables
variable "ami" {
  description = "AMI ID for EC2 instance"
  type        = string
  default     = "ami-0c02fb55956c7d316"  # Amazon Linux 2 in us-east-1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 20
}
