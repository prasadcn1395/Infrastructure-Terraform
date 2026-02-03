# Security Group Module - Variables

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = "Security group managed by Terraform"
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "enable_ssh" {
  description = "Enable SSH access"
  type        = bool
  default     = true
}

variable "enable_http" {
  description = "Enable HTTP access"
  type        = bool
  default     = true
}

variable "enable_https" {
  description = "Enable HTTPS access"
  type        = bool
  default     = true
}

variable "ssh_cidrs" {
  description = "List of CIDR blocks allowed to SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "http_cidrs" {
  description = "List of CIDR blocks allowed for HTTP"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "https_cidrs" {
  description = "List of CIDR blocks allowed for HTTPS"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
