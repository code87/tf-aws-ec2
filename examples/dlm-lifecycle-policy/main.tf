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

module "my_dlm_lifecycle_policy" {
  source = "../../modules/dlm-lifecycle-policy"

  name_prefix          = "test-project-staging"
  target_instance_name = "test-project-webserver"
  interval             = 24
  time                 = "03:30"
  snapshot_count       = 3
}

output "my_dlm_lifecycle_policy_id" {
  value = module.my_dlm_lifecycle_policy.dlm_lifecycle_policy_id
}

output "my_dlm_lifecycle_policy_arn" {
  value = module.my_dlm_lifecycle_policy.dlm_lifecycle_policy_arn
}
