data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = merge(var.tags, {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Purpose     = "Public DevOps Portfolio Template"
  })

  ecs_subnet_ids = var.ecs_subnet_type == "private" ? aws_subnet.private[*].id : aws_subnet.public[*].id

  listener_services = {
    for name, service in var.services : name => service
    if name != var.default_service_name && length(service.path_patterns) > 0
  }
}
