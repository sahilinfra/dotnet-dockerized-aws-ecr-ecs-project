module "networking" {
  source = "./modules/networking"

  name_prefix          = local.name_prefix
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = data.aws_availability_zones.available.names
  enable_nat_gateway   = var.enable_nat_gateway
  tags                 = local.common_tags
}

module "security" {
  source = "./modules/security"

  name_prefix        = local.name_prefix
  vpc_id             = module.networking.vpc_id
  services           = var.services
  allowed_http_cidrs = var.allowed_http_cidrs
  create_rds         = var.create_rds
  tags               = local.common_tags
}

module "storage" {
  source = "./modules/storage"

  name_prefix = local.name_prefix
  tags        = local.common_tags
}

module "ecr" {
  source = "./modules/ecr"

  name_prefix = local.name_prefix
  services    = var.services
  tags        = local.common_tags
}

module "iam" {
  source = "./modules/iam"

  name_prefix       = local.name_prefix
  backup_bucket_arn = module.storage.backup_bucket_arn
  tags              = local.common_tags
}

module "logs" {
  source = "./modules/logs"

  name_prefix = local.name_prefix
  services    = var.services
  tags        = local.common_tags
}

module "alb" {
  source = "./modules/alb"

  name_prefix           = local.name_prefix
  vpc_id                = module.networking.vpc_id
  public_subnet_ids     = module.networking.public_subnet_ids
  alb_security_group_id = module.security.alb_security_group_id
  services              = var.services
  default_service_name  = var.default_service_name
  certificate_arn       = var.certificate_arn
  hosted_zone_id        = var.hosted_zone_id
  domain_name           = var.domain_name
  tags                  = local.common_tags
}

module "ecs" {
  source = "./modules/ecs"

  name_prefix             = local.name_prefix
  aws_region              = var.aws_region
  services                = var.services
  ecr_repository_urls     = module.ecr.repository_urls
  log_group_names         = module.logs.log_group_names
  task_execution_role_arn = module.iam.task_execution_role_arn
  task_role_arn           = module.iam.task_role_arn
  ecs_subnet_ids          = var.ecs_subnet_type == "private" ? module.networking.private_subnet_ids : module.networking.public_subnet_ids
  ecs_security_group_id   = module.security.ecs_tasks_security_group_id
  assign_public_ip        = var.assign_public_ip
  target_group_arns       = module.alb.target_group_arns
  tags                    = local.common_tags

  depends_on = [module.alb]
}

module "database" {
  source = "./modules/database"

  create_rds             = var.create_rds
  name_prefix            = local.name_prefix
  private_subnet_ids     = module.networking.private_subnet_ids
  rds_security_group_id  = module.security.rds_security_group_id
  db_name                = var.db_name
  db_username            = var.db_username
  db_instance_class      = var.db_instance_class
  db_allocated_storage   = var.db_allocated_storage
  db_deletion_protection = var.db_deletion_protection
  tags                   = local.common_tags
}
