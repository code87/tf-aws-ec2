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

data "aws_vpc" "my_vpc" {
  default = true
}

module "my_web_security_group" {
  source = "../../modules/https-ssh-security-group"

  name_prefix = "myproject-staging"
  vpc_id      = data.aws_vpc.my_vpc.id
}

output "my_web_security_group_id" {
  value = module.my_web_security_group.security_group_id
}
