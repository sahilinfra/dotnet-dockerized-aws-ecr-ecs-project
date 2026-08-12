resource "aws_cloudwatch_log_group" "service" {
  for_each = var.services

  name              = "/ecs/${local.name_prefix}-${each.key}"
  retention_in_days = 30

  tags = merge(local.common_tags, {
    Service = each.key
  })
}
