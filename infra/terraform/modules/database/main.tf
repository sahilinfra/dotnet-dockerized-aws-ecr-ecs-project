resource "random_password" "db" {
  count = var.create_rds ? 1 : 0

  length           = 24
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_db_subnet_group" "app" {
  count = var.create_rds ? 1 : 0

  name       = "${var.name_prefix}-db-subnets"
  subnet_ids = var.private_subnet_ids

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-db-subnets"
  })
}

resource "aws_db_instance" "app" {
  count = var.create_rds ? 1 : 0

  identifier                 = "${var.name_prefix}-postgres"
  engine                     = "postgres"
  engine_version             = "16.3"
  instance_class             = var.db_instance_class
  allocated_storage          = var.db_allocated_storage
  db_name                    = var.db_name
  username                   = var.db_username
  password                   = random_password.db[0].result
  db_subnet_group_name       = aws_db_subnet_group.app[0].name
  vpc_security_group_ids     = [var.rds_security_group_id]
  backup_retention_period    = 7
  storage_encrypted          = true
  publicly_accessible        = false
  skip_final_snapshot        = true
  deletion_protection        = var.db_deletion_protection
  auto_minor_version_upgrade = true

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-postgres"
  })
}
