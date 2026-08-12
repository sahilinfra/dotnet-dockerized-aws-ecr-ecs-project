variable "aws_region" {
  description = "AWS region used for the sample infrastructure."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Public-safe project name used for AWS resource naming."
  type        = string
  default     = "sampleapp"
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the application VPC."
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks for the load balancer and optional public ECS tasks."
  type        = list(string)
  default     = ["10.20.10.0/24", "10.20.11.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks for ECS tasks and optional database resources."
  type        = list(string)
  default     = ["10.20.20.0/24", "10.20.21.0/24"]
}

variable "enable_nat_gateway" {
  description = "Create one NAT gateway for private subnet outbound access. Disabled by default to keep the template cost-aware."
  type        = bool
  default     = false
}

variable "ecs_subnet_type" {
  description = "Subnets where ECS tasks run. Use public for low-cost demos, private with enable_nat_gateway=true for production-like setups."
  type        = string
  default     = "public"

  validation {
    condition     = contains(["public", "private"], var.ecs_subnet_type)
    error_message = "ecs_subnet_type must be public or private."
  }
}

variable "assign_public_ip" {
  description = "Assign public IPs to ECS tasks. Keep true when ecs_subnet_type is public."
  type        = bool
  default     = true
}

variable "allowed_http_cidrs" {
  description = "CIDR blocks allowed to reach the public load balancer."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "certificate_arn" {
  description = "Optional ACM certificate ARN. When set, HTTP redirects to HTTPS and HTTPS forwards to ECS."
  type        = string
  default     = ""
}

variable "hosted_zone_id" {
  description = "Optional Route 53 hosted zone ID for creating a DNS alias record."
  type        = string
  default     = ""
}

variable "domain_name" {
  description = "Optional DNS name for the ALB alias, for example app.example.com."
  type        = string
  default     = ""
}

variable "default_service_name" {
  description = "Service used as the ALB default target."
  type        = string
  default     = "frontend"
}

variable "services" {
  description = "ECS services deployed by this template."
  type = map(object({
    container_name    = string
    container_port    = number
    cpu               = number
    memory            = number
    desired_count     = number
    image_tag         = string
    health_check_path = string
    path_patterns     = list(string)
    environment       = map(string)
  }))

  default = {
    backend = {
      container_name    = "webapi-api"
      container_port    = 80
      cpu               = 512
      memory            = 1024
      desired_count     = 1
      image_tag         = "latest_be"
      health_check_path = "/"
      path_patterns     = ["/api/*"]
      environment = {
        ASPNETCORE_ENVIRONMENT = "Development"
        ASPNETCORE_URLS        = "http://+:80"
      }
    }
    frontend = {
      container_name    = "webapi-frontend"
      container_port    = 44421
      cpu               = 256
      memory            = 512
      desired_count     = 1
      image_tag         = "latest_fe"
      health_check_path = "/"
      path_patterns     = []
      environment       = {}
    }
  }
}

variable "create_rds" {
  description = "Create an optional PostgreSQL RDS instance to demonstrate database provisioning."
  type        = bool
  default     = false
}

variable "db_name" {
  description = "Optional sample database name."
  type        = string
  default     = "sampleapp"
}

variable "db_username" {
  description = "Database admin username for the optional RDS instance."
  type        = string
  default     = "sampleadmin"
}

variable "db_instance_class" {
  description = "Instance class for the optional RDS instance."
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Allocated storage in GB for the optional RDS instance."
  type        = number
  default     = 20
}

variable "db_deletion_protection" {
  description = "Enable deletion protection for the optional RDS instance."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags applied to created resources."
  type        = map(string)
  default     = {}
}
