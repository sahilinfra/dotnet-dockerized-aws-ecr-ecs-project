# Terraform Infrastructure Template

This folder contains public-safe Terraform templates for the sample .NET application deployment. It is designed for portfolio review and does not include client names, live account IDs, secrets, domains, or proprietary configuration.

## What It Builds

- VPC with public and private subnets
- Internet gateway and optional NAT gateway
- Application Load Balancer with HTTP and optional HTTPS
- ECS Fargate cluster, task definitions, and services
- ECR repositories for backend and frontend images
- CloudWatch log groups
- IAM task execution and task roles
- S3 backup bucket with encryption, versioning, lifecycle, and public access blocking
- Optional private PostgreSQL RDS instance
- Optional Route 53 alias record

## Usage

```bash
cd infra/terraform
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform fmt
terraform validate
terraform plan
```

Set `certificate_arn`, `hosted_zone_id`, and `domain_name` only when deploying with your own ACM certificate and DNS zone.

For a low-cost demo, keep:

```hcl
ecs_subnet_type    = "public"
assign_public_ip   = true
enable_nat_gateway = false
create_rds         = false
```

For a more production-like setup, use private ECS subnets and enable NAT:

```hcl
ecs_subnet_type    = "private"
assign_public_ip   = false
enable_nat_gateway = true
```

## Safety Notes

- Do not commit `terraform.tfvars`, `.terraform/`, or state files.
- Use remote state and locking for real environments.
- Replace placeholder names and image tags with values from your own AWS account before applying.
