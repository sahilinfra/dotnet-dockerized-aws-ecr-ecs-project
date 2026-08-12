variable "create_rds" {
  description = "Whether to create the RDS instance."
  type        = bool
}

variable "name_prefix" {
  description = "Prefix used for resource names."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for RDS."
  type        = list(string)
}

variable "rds_security_group_id" {
  description = "Security group ID for RDS."
  type        = string
  nullable    = true
}

variable "db_name" {
  description = "Database name."
  type        = string
}

variable "db_username" {
  description = "Database admin username."
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
}

variable "db_allocated_storage" {
  description = "Allocated database storage in GB."
  type        = number
}

variable "db_deletion_protection" {
  description = "Enable RDS deletion protection."
  type        = bool
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}
