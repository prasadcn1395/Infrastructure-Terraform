# Production Environment Main Configuration

module "vpc" {
  source = "../../modules/vpc"

  vpc_name              = "${var.project_name}-vpc"
  environment           = var.environment
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidr    = var.public_subnet_cidr
  private_subnet_cidr   = var.private_subnet_cidr
  availability_zone     = var.availability_zone
  create_private_subnet = var.create_private_subnet
}

module "security_group" {
  source = "../../modules/security_group"

  security_group_name = "${var.project_name}-sg"
  vpc_id              = module.vpc.vpc_id
  environment         = var.environment
  enable_ssh          = var.enable_ssh
  ssh_cidrs           = var.ssh_cidrs
}

module "ec2" {
  source = "../../modules/ec2"

  ami                   = var.ami
  instance_type         = var.instance_type
  instance_name         = "${var.project_name}-instance"
  environment           = var.environment
  subnet_id             = module.vpc.public_subnet_id
  security_group_ids    = [module.security_group.security_group_id]
  associate_public_ip   = true
  root_volume_size      = var.root_volume_size
}
