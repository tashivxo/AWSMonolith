# Terraform variables file for AWS Monolithic Architecture

aws_region      = "us-east-1"
project_name    = "aws-monolith"

# VPC Configuration
vpc_cidr              = "10.0.0.0/16"
public_subnet_1_cidr  = "10.0.1.0/24"
public_subnet_2_cidr  = "10.0.2.0/24"
private_subnet_1_cidr = "10.0.10.0/24"
private_subnet_2_cidr = "10.0.11.0/24"

# EC2 Configuration
instance_type = "t3.micro"  # Free tier eligible

# Auto Scaling Group Configuration
asg_min_size         = 2
asg_max_size         = 4
asg_desired_capacity = 2

# SSH Access (restrict to your IP for production)
ssh_cidr = "0.0.0.0/0"

# RDS Configuration
db_instance_class    = "db.t3.micro"  # Free tier eligible
db_allocated_storage = 20
db_name              = "monolithdb"
db_username          = "admin"
