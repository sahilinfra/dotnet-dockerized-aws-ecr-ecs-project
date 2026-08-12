output "alb_dns_name" {
  description = "Application Load Balancer DNS name."
  value       = aws_lb.app.dns_name
}

output "ecs_cluster_name" {
  description = "ECS cluster name."
  value       = aws_ecs_cluster.main.name
}

output "ecr_repository_urls" {
  description = "ECR repository URLs keyed by service name."
  value = {
    for name, repo in aws_ecr_repository.service : name => repo.repository_url
  }
}

output "backup_bucket_name" {
  description = "S3 bucket for database/application backup examples."
  value       = aws_s3_bucket.backups.bucket
}

output "rds_endpoint" {
  description = "Optional RDS endpoint when create_rds is true."
  value       = var.create_rds ? aws_db_instance.app[0].endpoint : null
  sensitive   = true
}
