variable "name_prefix" {
  description = "Prefix to prepend resource names. Example: myproject-staging"
  type        = string
}

variable "vpc_id" {
  description = "ID of VPC in which the Security Group must be created"
  type        = string
}
