variable "name_prefix" {
  description = "Prefix used for resource names."
  type        = string
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}
