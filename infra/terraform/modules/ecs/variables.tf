variable "name_prefix" {
  description = "Prefix used for resource names."
  type        = string
}

variable "aws_region" {
  description = "AWS region used for log configuration."
  type        = string
}

variable "services" {
  description = "ECS services to deploy."
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
}

variable "ecr_repository_urls" {
  description = "ECR repository URLs keyed by service name."
  type        = map(string)
}

variable "log_group_names" {
  description = "CloudWatch log group names keyed by service name."
  type        = map(string)
}

variable "task_execution_role_arn" {
  description = "ECS task execution role ARN."
  type        = string
}

variable "task_role_arn" {
  description = "ECS task role ARN."
  type        = string
}

variable "ecs_subnet_ids" {
  description = "Subnet IDs where ECS tasks run."
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "Security group ID for ECS tasks."
  type        = string
}

variable "assign_public_ip" {
  description = "Assign public IPs to ECS tasks."
  type        = bool
}

variable "target_group_arns" {
  description = "ALB target group ARNs keyed by service name."
  type        = map(string)
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}
