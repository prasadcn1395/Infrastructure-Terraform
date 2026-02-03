# Security Group Module - Main Resources

resource "aws_security_group" "main" {
  name        = var.security_group_name
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    Name        = var.security_group_name
    Environment = var.environment
  }
}

# SSH Ingress Rule
resource "aws_security_group_rule" "ssh" {
  count             = var.enable_ssh ? 1 : 0
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.ssh_cidrs
  security_group_id = aws_security_group.main.id
}

# HTTP Ingress Rule
resource "aws_security_group_rule" "http" {
  count             = var.enable_http ? 1 : 0
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.http_cidrs
  security_group_id = aws_security_group.main.id
}

# HTTPS Ingress Rule
resource "aws_security_group_rule" "https" {
  count             = var.enable_https ? 1 : 0
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.https_cidrs
  security_group_id = aws_security_group.main.id
}

# Egress Rule (Allow all outbound)
resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main.id
}
