resource "random_password" "db" {
  count = var.create_rds ? 1 : 0

  length  = 24
  special = true
}

resource "aws_db_subnet_group" "app" {
  count = var.create_rds ? 1 : 0

  name       = "${local.name_prefix}-db-subnets"
  subnet_ids = aws_subnet.private[*].id

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-db-subnets"
  })
}

resource "aws_db_instance" "app" {
  count = var.create_rds ? 1 : 0

  identifier                 = "${local.name_prefix}-postgres"
  engine                     = "postgres"
  engine_version             = "16.3"
  instance_class             = var.db_instance_class
  allocated_storage          = var.db_allocated_storage
  db_name                    = var.db_name
  username                   = var.db_username
  password                   = random_password.db[0].result
  db_subnet_group_name       = aws_db_subnet_group.app[0].name
  vpc_security_group_ids     = [aws_security_group.rds[0].id]
  backup_retention_period    = 7
  storage_encrypted          = true
  publicly_accessible        = false
  skip_final_snapshot        = true
  deletion_protection        = var.db_deletion_protection
  auto_minor_version_upgrade = true

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-postgres"
  })
}
