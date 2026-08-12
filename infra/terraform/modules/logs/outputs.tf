output "log_group_names" {
  description = "CloudWatch log group names keyed by service name."
  value = {
    for name, group in aws_cloudwatch_log_group.service : name => group.name
  }
}
