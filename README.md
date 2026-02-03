# Terraform Modular Infrastructure

This project uses Terraform modules to manage AWS infrastructure across multiple environments (dev, prod).

## Project Structure

```
.
├── modules/                    # Reusable Terraform modules
│   ├── vpc/                   # VPC module with networking components
│   │   ├── main.tf            # VPC, Subnets, IGW, Route Tables
│   │   ├── variables.tf       # Input variables
│   │   └── outputs.tf         # Output values
│   ├── security_group/        # Security Group module
│   │   ├── main.tf            # Security group and rules
│   │   ├── variables.tf       # Input variables
│   │   └── outputs.tf         # Output values
│   └── ec2/                   # EC2 instance module
│       ├── main.tf            # EC2 instance configuration
│       ├── variables.tf       # Input variables
│       └── outputs.tf         # Output values
└── environments/              # Environment-specific configurations
    ├── dev/                   # Development environment
    │   ├── provider.tf        # Provider configuration
    │   ├── main.tf            # Module instantiation
    │   ├── variables.tf       # Dev-specific variables
    │   └── outputs.tf         # Environment outputs
    └── prod/                  # Production environment
        ├── provider.tf        # Provider configuration
        ├── main.tf            # Module instantiation
        ├── variables.tf       # Prod-specific variables
        └── outputs.tf         # Environment outputs
```

## Modules Overview

### VPC Module
Creates a complete VPC with networking components:
- **VPC**: Main VPC with configurable CIDR
- **Public Subnet**: For public-facing resources
- **Private Subnet**: Optional, for backend resources
- **Internet Gateway**: For public internet access
- **Route Tables**: For routing configuration
- **Route Table Associations**: Connects subnets to route tables

**Key Variables:**
- `vpc_name`: Name for the VPC
- `environment`: Environment identifier
- `vpc_cidr`: VPC CIDR block (e.g., 10.0.0.0/16)
- `public_subnet_cidr`: Public subnet CIDR
- `private_subnet_cidr`: Private subnet CIDR
- `create_private_subnet`: Boolean to create private subnet
- `availability_zone`: AWS availability zone

### Security Group Module
Creates and manages security group rules:
- **Configurable Rules**: SSH, HTTP, HTTPS
- **Flexible CIDR Blocks**: Per rule configuration
- **Egress Rules**: Allow all outbound traffic by default

**Key Variables:**
- `security_group_name`: Name of the security group
- `vpc_id`: VPC where SG will be created
- `enable_ssh`: Enable SSH access (default: true)
- `enable_http`: Enable HTTP access (default: true)
- `enable_https`: Enable HTTPS access (default: true)
- `ssh_cidrs`: List of CIDR blocks for SSH
- `http_cidrs`: List of CIDR blocks for HTTP
- `https_cidrs`: List of CIDR blocks for HTTPS

### EC2 Module
Creates and configures EC2 instances:
- **Instance Configuration**: AMI, instance type, networking
- **Storage Configuration**: Root volume size and type
- **Public IP Assignment**: Optional public IP association

**Key Variables:**
- `ami`: AMI ID to use
- `instance_type`: EC2 instance type (t2.micro, t3.small, etc.)
- `instance_name`: Name tag for the instance
- `subnet_id`: Subnet for instance placement
- `security_group_ids`: Associated security groups
- `associate_public_ip`: Assign public IP (default: true)
- `root_volume_size`: Root volume size in GB

## Usage

### Deploy to Development Environment

```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

### Deploy to Production Environment

```bash
cd environments/prod
terraform init
terraform plan
terraform apply
```

### Customizing Environments

Each environment has its own `variables.tf` file. You can override defaults:

**Development (default values):**
- VPC CIDR: 10.0.0.0/16
- Instance Type: t2.micro
- Root Volume: 20GB
- SSH Access: 0.0.0.0/0 (open)
- Private Subnet: Not created

**Production (default values):**
- VPC CIDR: 10.1.0.0/16
- Instance Type: t3.small
- Root Volume: 50GB
- SSH Access: 10.1.0.0/16 (VPC only)
- Private Subnet: Created

### Override Variables

Create a `terraform.tfvars` file in each environment directory:

```hcl
# environments/prod/terraform.tfvars
region            = "us-west-2"
instance_type     = "t3.medium"
root_volume_size  = 100
ssh_cidrs         = ["203.0.113.0/24"]  # Your office IP
```

## Module Outputs

All modules export outputs that can be referenced by other modules or used to display important information:

### VPC Module Outputs
- `vpc_id`: VPC ID
- `public_subnet_id`: Public subnet ID
- `private_subnet_id`: Private subnet ID (null if not created)
- `internet_gateway_id`: IGW ID
- `public_route_table_id`: Route table ID

### Security Group Module Outputs
- `security_group_id`: Security group ID
- `security_group_name`: Security group name
- `security_group_arn`: Security group ARN

### EC2 Module Outputs
- `instance_id`: EC2 instance ID
- `instance_public_ip`: Public IP address
- `instance_private_ip`: Private IP address
- `instance_arn`: Instance ARN

## Scaling and Extension

To add more environments:
1. Create a new directory under `environments/` (e.g., `staging/`)
2. Copy the structure from `dev/` or `prod/`
3. Customize variables as needed

To add more resources:
1. Create a new module directory under `modules/`
2. Define resources in `main.tf`
3. Define inputs in `variables.tf`
4. Define outputs in `outputs.tf`
5. Reference the module in environment `main.tf` files

## Best Practices

1. **Always use `terraform plan` before apply** to review changes
2. **Keep environment variables separate** for easy management
3. **Use meaningful names** for resources with environment prefix
4. **Restrict SSH access** in production environments
5. **Use state locking** for team environments (S3 backend recommended)
6. **Tag resources** properly for cost tracking and organization

## Troubleshooting

If you encounter issues:
- Verify AWS credentials: `aws sts get-caller-identity`
- Check region configuration: `terraform get`
- Validate syntax: `terraform validate`
- Review logs: `TF_LOG=DEBUG terraform apply`

## Clean Up

To destroy resources:

```bash
cd environments/dev  # or prod
terraform destroy
```

Confirm when prompted.

