variable "name_prefix" {
  description = "Prefix used for resource names."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "services" {
  description = "Service definitions used to create ECS task ingress rules."
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

variable "allowed_http_cidrs" {
  description = "CIDR blocks allowed to reach the public load balancer."
  type        = list(string)
}

variable "create_rds" {
  description = "Whether to create the RDS security group."
  type        = bool
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}
