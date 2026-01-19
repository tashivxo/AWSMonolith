# Terraform Infrastructure as Code for AWS Monolithic Architecture

This directory contains the complete Infrastructure as Code (IaC) definition for the AWS Monolithic Architecture using Terraform.

## Overview

The Terraform configuration deploys a scalable, highly available AWS infrastructure including:

- **VPC with Public/Private Subnets**: Multi-AZ setup across 2 availability zones
- **Internet Gateway & NAT Gateway**: Secure routing for inbound/outbound traffic
- **Application Load Balancer (ALB)**: Distributes traffic to EC2 instances
- **EC2 Auto Scaling Group**: Automatically scales EC2 instances based on demand
- **RDS MySQL Database**: Multi-AZ relational database
- **S3 Bucket**: Static asset storage with versioning and encryption
- **CloudFront Distribution**: CDN for static content caching and delivery
- **IAM Roles & Policies**: Least-privilege access control
- **Security Groups**: Network-level access control for ALB, EC2, and RDS

## Files

- `main.tf`: Primary Terraform configuration with all AWS resources
- `variables.tf`: Variable definitions with descriptions and defaults
- `terraform.tfvars`: Variable values for customization
- `user_data.sh`: EC2 initialization script that installs Apache web server
- `README.md`: This file

## Prerequisites

1. **Terraform installed**: v1.0 or higher
2. **AWS CLI configured**: With valid AWS credentials
3. **AWS Account**: Free Tier eligible (all resources use free tier instance types)

## Setup Instructions

### 1. Configure AWS Credentials

```bash
aws configure
```

Or set environment variables:
```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

### 2. Initialize Terraform

```bash
cd terraform
terraform init
```

### 3. Review the Plan

```bash
terraform plan
```

This will show all resources that will be created.

### 4. Apply Configuration

```bash
terraform apply
```

Type `yes` when prompted to create the resources.

### 5. Get Outputs

After successful deployment:
```bash
terraform output
```

Key outputs:
- **ALB DNS Name**: Use this to access your application
- **CloudFront Domain**: For cached static content
- **RDS Endpoint**: Database connection string
- **S3 Bucket Name**: For storing static assets

## Configuration

### Customize Variables

Edit `terraform.tfvars` to modify:

- **AWS Region**: Change `aws_region` to deploy in different region
- **VPC CIDR**: Modify `vpc_cidr` and subnet ranges
- **Instance Type**: Change `instance_type` (t3.micro is free tier)
- **Database**: Adjust `db_instance_class`, `db_allocated_storage`
- **Scaling**: Modify `asg_min_size`, `asg_max_size`, `asg_desired_capacity`
- **SSH Access**: Restrict `ssh_cidr` to your IP (e.g., "YOUR.IP.ADDRESS/32")

### Update User Data

Edit `user_data.sh` to customize EC2 instance setup:
- Install additional packages
- Deploy application code
- Configure monitoring agents

## AWS Free Tier Considerations

This configuration uses free tier eligible resources:
- **EC2**: t3.micro instances (750 hours/month free)
- **RDS**: db.t3.micro instance (750 hours/month free)
- **NAT Gateway**: Charges apply (~$32/month if kept running)
- **ALB**: Charges apply (~$16/month)
- **Data Transfer**: Charges apply based on usage

**Cost Estimate**: ~$50-80/month with current configuration

## Common Terraform Commands

```bash
# Initialize working directory
terraform init

# Format configuration files
terraform fmt

# Validate configuration
terraform validate

# Plan changes
terraform plan

# Apply changes
terraform apply

# Destroy all resources
terraform destroy

# View outputs
terraform output

# View specific output
terraform output alb_dns_name
```

## Security Best Practices

1. **SSH Access**: Restrict `ssh_cidr` to your specific IP address
2. **Database Password**: The RDS password is auto-generated and stored in Terraform state
3. **State File**: Store `terraform.tfstate` securely (use remote state for production)
4. **IAM Policies**: Currently uses broad permissions; restrict further for production
5. **S3 Bucket**: Public access is blocked; configure bucket policies as needed

## Troubleshooting

### Resources not creating
```bash
terraform apply -auto-approve
```

### View detailed logs
```bash
export TF_LOG=DEBUG
terraform apply
```

### Destroy resources
```bash
terraform destroy
```

## Next Steps

1. Deploy your monolithic application to EC2 instances
2. Configure RDS connection strings in your application
3. Upload static assets to S3
4. Monitor application metrics in CloudWatch
5. Set up auto-scaling policies based on metrics

## Support

For issues or questions about this infrastructure:
1. Check Terraform logs: `export TF_LOG=DEBUG`
2. Review AWS console for resource status
3. Consult AWS documentation: https://docs.aws.amazon.com/
4. Check Terraform AWS Provider docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
