variable "name_prefix" {
  description = "Prefix used for resource names."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the load balancer."
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security group ID attached to the ALB."
  type        = string
}

variable "services" {
  description = "Services exposed through target groups."
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

variable "default_service_name" {
  description = "Service used as the ALB default target."
  type        = string
}

variable "certificate_arn" {
  description = "Optional ACM certificate ARN."
  type        = string
}

variable "hosted_zone_id" {
  description = "Optional Route 53 hosted zone ID."
  type        = string
}

variable "domain_name" {
  description = "Optional DNS name for the ALB alias."
  type        = string
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}
