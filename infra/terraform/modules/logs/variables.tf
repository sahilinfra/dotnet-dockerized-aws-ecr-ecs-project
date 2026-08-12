variable "name_prefix" {
  description = "Prefix used for resource names."
  type        = string
}

variable "services" {
  description = "Services requiring CloudWatch log groups."
  type = map(object({
    container_name    = string
    container_port    = number
    cpu               = number
    memory            = number
    desired_count     = number
    image_tag         = string
    health_check_path = string
    path_patterns     = list(string)
    environment       = map(string)
  }))
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}
