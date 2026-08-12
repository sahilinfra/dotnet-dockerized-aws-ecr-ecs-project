output "cluster_name" {
  description = "ECS cluster name."
  value       = aws_ecs_cluster.main.name
}

output "service_names" {
  description = "ECS service names keyed by service name."
  value = {
    for name, service in aws_ecs_service.service : name => service.name
  }
}
