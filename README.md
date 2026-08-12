# .NET Admin Portal - DevOps Portfolio

Public-safe sample using **Docker**, **Docker Compose**, **Terraform**, **GitHub Actions**, and **AWS ECR to ECS Fargate**.

Application source is stubbed. AWS account IDs, domains, secrets, client names, and proprietary configuration are intentionally not included.

## Layout

- `WebApi/` - ASP.NET Core API Dockerfiles and minimal stub
- `WebApi.CronJob/` - background worker Dockerfile and minimal stub
- `WebApi/ClientApp/` - frontend Dockerfiles and stub package metadata
- `docker-compose*.yml` - local build templates for backend, frontend, and worker containers
- `.github/workflows/` - build/deploy workflows for ECS plus Terraform validation
- `infra/ecs/` - sample ECS task definitions used by GitHub Actions deployments
- `infra/terraform/` - reusable Terraform templates for VPC, ALB, ECS Fargate, ECR, IAM, CloudWatch, S3 backups, and optional RDS/DNS/HTTPS

## Local Build

```bash
docker compose -f docker-compose.dev.yml up --build
```

## Terraform

The Terraform templates are generic and safe for a public portfolio repository.

```bash
cd infra/terraform
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform validate
terraform plan
```

See `infra/terraform/README.md` for the full infrastructure overview and usage notes.
