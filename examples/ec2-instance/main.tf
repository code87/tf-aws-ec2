terraform {
  required_version = "~> 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_availability_zones" "availability_zones" {
  state = "available"
}

data "aws_subnet" "default_subnet" {
  availability_zone_id = data.aws_availability_zones.availability_zones.zone_ids[0]
  default_for_az       = true
}

data "aws_ami" "code87_ubuntu_docker_compose" {
  owners      = ["412167390459"]
  most_recent = true
  filter {
    name   = "name"
    values = ["code87-ubuntu-docker-compose-*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

variable "ssh_key_pair" {
  description = "SSH key-pair to use for EC2 Instance"
  type        = string
}

resource "aws_kms_key" "test_project_kms_key" {
  description             = "Test Project KMS Key"
  deletion_window_in_days = 7
}

module "my_web_security_group" {
  source = "../../modules/https-ssh-security-group"

  name_prefix = "test-project"
  vpc_id      = data.aws_vpc.default_vpc.id
}

module "my_ec2_instance" {
  source = "../../modules/ec2-instance"

  name               = "test-project-webserver"
  ami_id             = data.aws_ami.code87_ubuntu_docker_compose.image_id
  instance_type      = "t3.nano"
  volume_encryption  = true
  kms_key_arn        = aws_kms_key.test_project_kms_key.arn
  ssh_key_pair       = var.ssh_key_pair
  subnet_id          = data.aws_subnet.default_subnet.id
  security_group_ids = [module.my_web_security_group.security_group_id]
}

output "instance_id" {
  value = module.my_ec2_instance.instance_id
}

output "instance_type" {
  value = module.my_ec2_instance.instance_type
}

output "instance_ami_id" {
  value = module.my_ec2_instance.instance_ami_id
}

output "instance_ssh_key_pair" {
  value = module.my_ec2_instance.instance_ssh_key_pair
}

output "public_ip" {
  value = module.my_ec2_instance.public_ip
}

output "public_dns" {
  value = module.my_ec2_instance.public_dns
}
