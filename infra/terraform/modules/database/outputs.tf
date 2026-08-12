output "rds_endpoint" {
  description = "Optional RDS endpoint."
  value       = try(aws_db_instance.app[0].endpoint, null)
  sensitive   = true
}
