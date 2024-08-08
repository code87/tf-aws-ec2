variable "name" {
  description = "EC2 Instance name. Example: myproject-webserver"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 Instance. Varies for different regions"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance type. Default: t3.micro"
  type        = string
  default     = "t3.micro"
}

variable "volume_size" {
  description = "Size of the volume in gibibytes (GiB). Default: 8 GiB"
  type        = number
  default     = 8
}

variable "volume_encryption" {
  description = "Enables or disables EC2 instance root volume encryption. Default: false"
  type        = bool
  default     = false
}

variable "kms_key_arn" {
  description = "KMS Custom-managed key ARN for EC2 instance root volume encryption. Default: null"
  type        = string
  default     = null
}

variable "ssh_key_pair" {
  description = "Key-pair name for SSH access to EC2 Instance"
  type        = string
}

variable "iam_instance_profile" {
  description = "EC2 Instance IAM profile name"
  type        = string
  default     = null
}

# TODO: specify type
variable "subnet_id" {
  description = "VPC Subnet ID to launch in"
}

# TODO: fix list item type
variable "security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(any)
}

variable "user_data" {
  description = "User Data script to execute when launching the instance"
  type        = string
  default     = null
}
