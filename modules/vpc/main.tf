# VPC Module - Main Resources

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name        = var.vpc_name
    Environment = var.environment
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.vpc_name}-igw"
    Environment = var.environment
  }
}

# Create a Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.vpc_name}-public-subnet"
    Environment = var.environment
    Type        = "Public"
  }
}

# Create a Private Subnet (optional)
resource "aws_subnet" "private" {
  count              = var.create_private_subnet ? 1 : 0
  vpc_id             = aws_vpc.main.id
  cidr_block         = var.private_subnet_cidr
  availability_zone  = var.availability_zone

  tags = {
    Name        = "${var.vpc_name}-private-subnet"
    Environment = var.environment
    Type        = "Private"
  }
}

# Create Route Table for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.vpc_name}-public-rt"
    Environment = var.environment
  }
}

# Associate Public Subnet with Route Table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
