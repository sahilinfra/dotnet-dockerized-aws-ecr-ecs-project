variable "name_prefix" {
  description = "Prefix used for resource names."
  type        = string
}

variable "backup_bucket_arn" {
  description = "S3 backup bucket ARN."
  type        = string
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}
