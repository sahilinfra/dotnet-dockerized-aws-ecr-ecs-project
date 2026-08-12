resource "aws_cloudwatch_log_group" "service" {
  for_each = var.services

  name              = "/ecs/${var.name_prefix}-${each.key}"
  retention_in_days = 30

  tags = merge(var.tags, {
    Service = each.key
  })
}
