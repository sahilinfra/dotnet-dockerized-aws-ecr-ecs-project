output "alb_dns_name" {
  description = "Application Load Balancer DNS name."
  value       = aws_lb.app.dns_name
}

output "target_group_arns" {
  description = "Target group ARNs keyed by service name."
  value = {
    for name, target_group in aws_lb_target_group.service : name => target_group.arn
  }
}
