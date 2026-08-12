output "alb_dns_name" {
  description = "Application Load Balancer DNS name."
  value       = module.alb.alb_dns_name
}

output "ecs_cluster_name" {
  description = "ECS cluster name."
  value       = module.ecs.cluster_name
}

output "ecr_repository_urls" {
  description = "ECR repository URLs keyed by service name."
  value       = module.ecr.repository_urls
}

output "backup_bucket_name" {
  description = "S3 bucket for database/application backup examples."
  value       = module.storage.backup_bucket_name
}

output "rds_endpoint" {
  description = "Optional RDS endpoint when create_rds is true."
  value       = module.database.rds_endpoint
  sensitive   = true
}
