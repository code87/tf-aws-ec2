variable "name_prefix" {
  description = "Prefix to prepend resource names. Example: myproject-staging"
  type        = string
}

variable "target_instance_name" {
  description = "Name of EC2 Instance to backup. Example: myproject-webserver"
  type        = string
}

variable "interval" {
  description = "How often lifecycle policy should be evaluated. Values: 1, 2, 4, 6, 8, 12, 24. Default: 24"
  type        = number
  default     = 24
}

variable "time" {
  description = "Time in 24 hour clock format that sets when the lifecycle policy should be evaluated. Example: 03:30"
  type        = string
}

variable "snapshot_count" {
  description = "How many snapshots to keep. Must be an integer between 1 and 1000. Default: 1"
  type        = number
  default     = 1
}
