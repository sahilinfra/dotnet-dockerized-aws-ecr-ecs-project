output "alb_security_group_id" {
  description = "ALB security group ID."
  value       = aws_security_group.alb.id
}

output "ecs_tasks_security_group_id" {
  description = "ECS task security group ID."
  value       = aws_security_group.ecs_tasks.id
}

output "rds_security_group_id" {
  description = "Optional RDS security group ID."
  value       = try(aws_security_group.rds[0].id, null)
}
